//
//  ScheduleConstants.h
//  Bowdoin Dining
//
//  Created by Ben Johnson on 8/3/10.
//  Copyright (c) 2010 __MyCompanyName__. All rights reserved.
//

// These intervals are defined by seconds since 12AM of current day
// If current time is after 12AM but before 1AM seconds calculates from past day at 12AM

//const int noMealForDay        00000
const int noMealForDay = 00000;


// Dining Halls (Monday through Friday)

// Moulton Express
const int mExpressLunchStart = 37800; // 10:30 a.m.
const int mExpressLunchStop  = 52200; //  2:30 p.m.



const int mExpressDinnerStart = 61200; //  5:00 p.m.
const int mExpressDinnerStop  = 72000; //  8:00 p.m.

// Moulton Breakfast
const int mHotBreakfastStart  = 26100; //  7:15 a.m.
const int mHotBreakfastStop   = 32400; //  9:00 a.m.

const int mColdBreakfastStart = 32400; //  9:00 a.m.
const int mColdBreakfastStop  = 37800; // 10:30 a.m.


// Moulton Lunch
const int mLunchStart         = 39600; // 11:00 a.m.
const int mLunchStop          = 50400; //  2:00 p.m.


// Moulton Dinner

const int mDinnerStart        = 61200; //  5:00 p.m.
const int mDinnerStop         = 68400; //  7:00 p.m.

///////////////////////////////////////////////

// Thorne Breakfast
const int tHotBreakfastStart  = 27000; //  7:30 a.m.
const int tHotBreakfastStop   = 34200; //  9:30 a.m.

// Thorne Lunch

const int tColdLunchStart     = 39600; // 11:00 a.m.
const int tColdLunchStop      = 41400; // 11:30 a.m. Continues into normal Lunch

const int tHotLunchStart      = 41400; // 11:30 a.m.
const int tHotLunchStop       = 47700; //  1:15 p.m.

// Thorne Dinner

const int tDinnerStart        = 61200; //  5:00 p.m.
const int tDinnerStop         = 70200; //  7:30 p.m.


///////////////////////////////////////////////

// Dining Halls (Weekends)

// Moulton Breakfast
const int mwkBreakfastStart   = 32400; //  9:00 a.m
const int mwkBreakfastStop    = 39600; // 11:00 a.m.

// Moulton Brunch
const int mwkBrunchStart      = 39600; // 11:00 a.m.
const int mwkBrunchStop       = 45000; // 12:30 p.m.

// Moulton Dinner
const int mwkDinnerStart      = 61200; //  5:00 p.m.
const int mwkDinnerStop       = 68400; //  7:00 p.m.


///////////////////////////////////////////////

// Thorne Brunch

const int twkBrunchStart      = 39600; // 11:00 a.m.
const int twkBrunchStop       = 48600; //  1:30 p.m.

// Thorne Dinner
const int twkDinnerStart      = 61200; //  5:00 p.m.
const int twkDinnerStop       = 70200; //  7:30 p.m.

// Super Snax (Thu, Fri, Sat)
const int sSnackStart         = 79200; // 10:00 p.m.
const int sSnackStop          = 90000; //  1:00 a.m.




// Smith Union Dining

// Cafe (Monday - Wednesday)
const int cmwMorningStart     = 27000; //  7:30 a.m.
const int cmwMorningStop      = 59400; //  4:30 p.m.

const int cmwNightStart       = 72000; //  8:00 p.m.
const int cmwNightStop        = 86400; //  MIDNIGHT


// Cafe (Thursday - Friday)
const int ctfMorningStart     = 27000; //  7:30 a.m.
const int ctfMorningStop      = 59400; //  4:30 p.m.


// Cafe Saturday
const int csaMorningStart     = 39600; // 11:00 a.m.
const int csaMorningStop      = 57600; //  4:00 p.m.

// Cafe Sunday
const int csuMorningStart     = 39600; // 11:00 a.m.
const int csuMorningStop      = 57600; //  4:00 p.m.

const int csuNightStart       = 72000; //  8:00 p.m.
const int csuNightStop        = 86400; //  MIDNIGHT


// The Pub (Thursday)
const int pubtStart           = 73800; //  8:30 p.m.
const int pubtStop            = 90000; //  1:00 a.m.

// The Pub (Friday)
const int pubfsStart          = 64800; //  6:00 p.m.
const int pubfsStop           = 79200; // 10:00 p.m.

// Grill (Monday - Wednesday)
const int grillmwStart        = 41400; // 11:30 a.m.
const int grillmwStop         = 86400; //  MIDNIGHT


// Grill (Thursday - Friday)
const int grilltfStart        = 41400; // 11:30 a.m.
const int grilltfStop         = 90000; //  1:00 a.m.

// Grill (Saturday)
const int grillsaStart        = 64800; //  6:00 p.m.
const int grillsaStop         = 86400; //  MIDNIGHT

// Grill (Sunday)
const int grillsuStart        = 66600; //  6:30 p.m.
const int grillsuStop         = 86400; //  MIDNIGHT



// Bowdoin Express (Monday - Friday)
const int emfStart            = 32400; //  9:00 a.m.
const int emfStop             = 86400; //  MIDNIGHT

// Bowdoin Express (Saturday - Sunday)
const int emssStart           = 39600; // 11:00 a.m.
const int emssStop            = 86400; //  MIDNIGHT

