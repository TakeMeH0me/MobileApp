package com.example.take_me_home

import android.appwidget.AppWidgetManager
import android.appwidget.AppWidgetProvider
import android.content.Context
import android.widget.RemoteViews
import es.antonborri.home_widget.HomeWidgetPlugin

/**
 * Implementation of App Widget functionality.
 */
class TakeMeHomeWidget : AppWidgetProvider() {
    override fun onUpdate(context: Context, appWidgetManager: AppWidgetManager, appWidgetIds: IntArray) {
        // There may be multiple widgets active, so update all of them
        for (appWidgetId in appWidgetIds) {
            val widgetData = HomeWidgetPlugin.getData(context)
            val json = widgetData.getString("routeinformation_json", "null")

            if (json == null)
            {
                updateAppWidget(context, appWidgetManager, appWidgetId, "no route")
            }
            else
            {
                updateAppWidget(context, appWidgetManager, appWidgetId, json.toString())
            }
        }
    }

    override fun onEnabled(context: Context) {
        // Enter relevant functionality for when the first widget is created
    }

    override fun onDisabled(context: Context) {
        // Enter relevant functionality for when the last widget is disabled
    }
}

internal fun updateAppWidget(context: Context, appWidgetManager: AppWidgetManager, appWidgetId: Int, str: String) {
    // Construct the RemoteViews object
    val views = RemoteViews(context.packageName, R.layout.take_me_home_widget)
    views.setTextViewText(R.id.appwidget_text, str)

    // Instruct the widget manager to update the widget
    appWidgetManager.updateAppWidget(appWidgetId, views)
}