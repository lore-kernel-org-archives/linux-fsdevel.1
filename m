Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A333F36E467;
	Wed, 30 Sep 2026 16:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790785949; cv=fail; b=lf80I9RcCI2OejgIUh4naBVOBDhfLxCzR9G9O59qg+8oGw8xIoybBFYPOtZK0GLTrYlQoS5SEvUzcf/0WpvvZ9vCJMBq/+ETTU6pExlM64kLN+lfEiTXs1VeFCEPvrxlUN4ZLdX//9T/8mb9AGs78JkhVnwIOQSrUU9ZDXMubcM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790785949; c=relaxed/simple;
	bh=2666WTGVZQQilfp2FC7akq62AqYgEIx8iVjrIQdiJV4=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cIhyaznoaXWOanYMa+Hq2/vWC3Vpo+nZbJ9iKNbDIfzRMwNzobxiCtIaHY1YkCiCFPbnZIpOrNHxmwp0BT2nUw4vHWuP806/tURWasDct4nYLEt9+UxWC6ZzzmL3mSnvUiCABc7XC9z2sHcTA69DiyHngs5Z9l0DTiIX+qIAifY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a4XrWbv8; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a4XrWbv8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790785946; x=1822321946;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=2666WTGVZQQilfp2FC7akq62AqYgEIx8iVjrIQdiJV4=;
  b=a4XrWbv8qP2U79HGYdlET0lJgMORz31hW32cRoZ4C+2U24Wbsg2Q2c5N
   F4kbXmBsfGxAzxFOA5jrSa26QJjRiP9rP7c2EtCd2cjmqS85oL45Ctpd6
   o9HsnvDNAysqqemupc6yQLJiGQfKd4LLCYrQghQBZDEEOnsdDLdpplRJ4
   /szgMUnlRvGm5ctajOcNwD5EG5mzFhkr6rOVPsHV/iK6XTFQBcbAV+r4I
   xT4sTnKW2b8jnvBi/FEc16rtWi5007j+F+iN8MZu60SIITFgi37EeCqCI
   b1T5j96v+PJxPn21aDENskogg9UbHOqkdn9KJgS8hXDuf0j121zqmCTYn
   A==;
X-CSE-ConnectionGUID: +rYFp23rRr6mINp5osdwsw==
X-CSE-MsgGUID: abfGvM9rTpC01GNK6bV1ag==
X-IronPort-AV: E=McAfee;i="6800,10657,11921"; a="90660409"
X-IronPort-AV: E=Sophos;i="6.27,132,1787036400"; 
   d="scan'208";a="90660409"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2026 09:32:17 -0700
X-CSE-ConnectionGUID: PtbVhxDFRPyb0OP1iqJMWA==
X-CSE-MsgGUID: 4a1vT4GETJinhzjjGXsBag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,132,1787036400"; 
   d="scan'208";a="303673059"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2026 09:32:17 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 30 Sep 2026 09:32:16 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Wed, 30 Sep 2026 09:32:16 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.68) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 30 Sep 2026 09:32:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RyauUB1a0VfcYXr5heqdFW08UTcRwLjiDiTjjsE5StMCyVn3jnugT96Cr86DxOwzFUKhiF2ehUmkTo+yo7XhRlUk+x9XUPdVNERL+9104Q11xDRWpvok4edk9FvVzDrY1iHQ5cKDaG1u0DbfqXq8VLjGaeGknTXkJIciGWtCe70V1zvGRyjngyNvFkPrE7Sr0ogpnm8/34mXCXg+lbs3CB6qdSMlGYxzHw/ADNcrOQOdC7cujEf/9XQ06/C+g8PkE/MN6buZ+Riw9iN7UFxCL3PdKQELgXL6bMAyLq/MRDDh8gcsDbSyUrgFGEir95DT4Y9a2JWw5yghEozF1JOBFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h/GgRSPBqNIfZy47tW0CtpCiI+la4jpV/uxyiBM2D6s=;
 b=Cb8DZlEDHyTG8Sq+tlsxQ6YIRxz2ZyEObkLtt+xm4lk8W7Lr9X7WaBXMP5ed2+LfJWOETZN+RWBv1tE09qCj/SrNiR7LnBJ9B6zAsYBU0b9XgfcLUhT5n2FBAVb3fUUpY8X7psnaoaXkONAwOme7htwVFKAV+cNLVal5PxX1QrzBjbwsPDM4tiNe40X4XPXgGWVsP1Re/8MSx4Kklc/1W2LsTsMSvx5kAxuRvuhv0z2ablIOdLlBZLVzpB8tXSPfksfmFxvFIGFl0bkL6/caI2erc9vW9OglOLaR6Asq2HIGYaaW/B9EZSEc5O9K3euSUqzrfH4Cj+Ivc+UaZbGYfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA2PR11MB5035.namprd11.prod.outlook.com (2603:10b6:806:116::21)
 by PH0PR11MB5808.namprd11.prod.outlook.com (2603:10b6:510:129::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.25; Wed, 30 Sep
 2026 16:32:13 +0000
Received: from SA2PR11MB5035.namprd11.prod.outlook.com
 ([fe80::9418:cd60:8ece:69c3]) by SA2PR11MB5035.namprd11.prod.outlook.com
 ([fe80::9418:cd60:8ece:69c3%5]) with mapi id 15.21.0472.015; Wed, 30 Sep 2026
 16:32:13 +0000
Message-ID: <e3772a51-eabc-4c31-b73d-f3187bf1b3b2@intel.com>
Date: Wed, 30 Sep 2026 22:01:55 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 6/7] VFS: add lockdep monitoring of DCACHE_PAR_LOOKUP
 lock.
To: NeilBrown <neil@brown.name>, Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
CC: Jan Kara <jack@suse.cz>, <linux-fsdevel@vger.kernel.org>, Jeff Layton
	<jlayton@kernel.org>, Amir Goldstein <amir73il@gmail.com>, Miklos Szeredi
	<miklos@szeredi.hu>, <linux-kernel@vger.kernel.org>,
	<ravitejax.veesam@intel.com>, "intel-gfx@lists.freedesktop.org"
	<intel-gfx@lists.freedesktop.org>, "intel-xe@lists.freedesktop.org"
	<intel-xe@lists.freedesktop.org>
References: <20260904215142.1060510-1-neilb@ownmail.net>
 <20260904215142.1060510-7-neilb@ownmail.net>
Content-Language: en-GB
From: "Borah, Chaitanya Kumar" <chaitanya.kumar.borah@intel.com>
In-Reply-To: <20260904215142.1060510-7-neilb@ownmail.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0293.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:221::7) To SA2PR11MB5035.namprd11.prod.outlook.com
 (2603:10b6:806:116::21)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PR11MB5035:EE_|PH0PR11MB5808:EE_
X-MS-Office365-Filtering-Correlation-Id: 497458c2-c680-4e4e-a6d1-08df1f105e10
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|23010399003|1800799024|56012099006|11063799006|4143699003|10067099003|29003799003|6133799003|12006099003|22082099003|25016099003|18002099003;
X-Microsoft-Antispam-Message-Info: UX5gkY66ndM8C32AF+n+RaOUDvIwV3ZgfTxU45gQuEkdXASzHKjPkjs2GXD/vAnovKKwxDo6eL+MzT6RxcIbuSw8w+Ye1dxwKsrB9WIEDFo651dLpbYTiVuKegZ/cm/r4OSinBI5dwlEepsy0YKHYIHQI2apnWJj9a1Bqu24Tg3zq1xI4IFncW0o9SoUiCGvV07rr6p4U3xzoK2W80yRvKvb3AS4TuMcWHNbIZuD3W1KLKZGBQApfFPPapO1I/xJgI7eXA8SoIMdqdOqW31F5SG13bFh7VcnTpmPCGvafrRzwfOW6R1zKBPZrQCoKnsG5YjvXOPPRE1pg1rnkpZw22thGftSEiAu3mzuBiqe3LCS/vhDwg4SpmiB6KzBFrEOmogdTpwj5Ux4BDJCxLmIG4lhZNT14gynkqE4NYr8nLGR4quOzRcS8bMvwyJQG/rnp/JXxvolMI3reJStyYP4QRuSApaTvBz1wAc5iqCFKyeO8zrEhmysX8ty/kmOOIgMWNjGrqY6p7hIpEUAdKpBmUbtO/EK5aGtY2XF8ERSXka+ZRaEjrX6MXyrKgzo4F8E1qjKv2gnx0WKkn0ioeWVCC4arrhvwpA2FZe5sky5EmNQ3Vx48XyDpVMq9bj21rsE
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB5035.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(23010399003)(1800799024)(56012099006)(11063799006)(4143699003)(10067099003)(29003799003)(6133799003)(12006099003)(22082099003)(25016099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MDU5VThpTEhDeTZtTHQ0K1B2VUZvUzV6SjNneDBHOFNqSnAwdXhSaHJialVs?=
 =?utf-8?B?bll0OXZnTngwbU5kMnR0TkNOcm81YndJaGZhaTNMaFAvejhDQnRvZXJCcDdY?=
 =?utf-8?B?TGFKZXZEQUY5QUtnam13Nm84ZXhJSjVqSmpQZUlhR2N1VlBBZlA5K2tTVDR6?=
 =?utf-8?B?VE16VlNFcTZEbnZoanByaFZ1a1BFVUdnZjAvbkhvcXZzSTk3NTRXNEtaSWcx?=
 =?utf-8?B?djRjWk5uK282SkhieXRPQ3EyOTJHSGdJYktFM3FRMWduTlZ2R1FBb3Y1VzVE?=
 =?utf-8?B?R3VBUXhJeC9IODlmUWNSQ0YyZmk3SkFqR2VGR2gyNHJRSXJnaC9lUlVibHNl?=
 =?utf-8?B?QzFtWEp1NUtPVDVoeVNSc0V1OS9mMUZwbHZSSFlFeStNUS8xVklUMjNLeitZ?=
 =?utf-8?B?UEluTStoZ25sRFRuTStoY1RVQ0JtMUhxRmJoTEdlWUliRGlSeFJhNnRLNTJp?=
 =?utf-8?B?TWp5ZmkyWExTY09TUlhLbkp1cHM4VzAwcExKbkNDNFdvd2lyYXdHR0ZRY3lq?=
 =?utf-8?B?cXZkeGNieTZVZ0oxL1ZTNUFmenNGQ2tlT3hLRGhHd0p5WmtJQXJtMkZNQkda?=
 =?utf-8?B?d2FFWDMxZ3pFc3FyeEdseXFjWENONXlHdDYzQy9YNWJ2eSsvNzRhU0pZUW1m?=
 =?utf-8?B?d3hOVzJJWVRaUEUwQUJEMDhzQy8rVVROZkY1YVBkeVRnMnkvWlNjTEJ6QjNK?=
 =?utf-8?B?U091YnNvSmdQTkNmVmM5cUtwOWRQOTltWG5sRlJZMTdFZ2dFV1B1NjFjSEt3?=
 =?utf-8?B?UFBKUFFXNUJwMERSK2xhbWJFNFVtZzJMR2I1RCtqMkg2TmM5aHFtOGZTZXFt?=
 =?utf-8?B?T05oWVpycnBLeVVnY3hnVTN1YkVOemVpWXZwTWowMkVKbGpIa0UreDRlUkdR?=
 =?utf-8?B?anpQWlZFeFdMKzhhSWZOVTRXMXpHT3k0OS84SkR0NUZZRnd1dk0rRDFsUndo?=
 =?utf-8?B?eVNMWmQyMzdyeE9pYnNtT2MwSFFUeWpjUzY4TVlwU0VYKzk4aUMyZGZjbDBk?=
 =?utf-8?B?OWZxRUpnaDVrUk56cS93R3Y1bE9uci82aGNJNkRoVWtvTW52ejV2bStJQVZn?=
 =?utf-8?B?NkxIcW9OLzg2NGpsZ21WT3YxYlRqdG9JWTZzc0pRNnVIbkhDOXhtWEdyRVlR?=
 =?utf-8?B?MVVXMEo1UGpvVE1tT2hqcmxPQmRJM3hPOFRkK0NsaHRWV0FwcnJzengxanFJ?=
 =?utf-8?B?TTR6Y05KRUcrR2hBejZ2cDFyM01YQ25QWmF3eWtoQjdRRlRYWEtsVFo2aTl4?=
 =?utf-8?B?RnRhNUV2aUlFa05iNWVldC9PcXE1d01BeG9ibTRjc3drZ29UemUxaGd4U1pY?=
 =?utf-8?B?TXM4UGpuc01xeTR2YUlJVFRoOFYvOUc2aUU5NndvQzdkUWRYam5qVFRyY3d2?=
 =?utf-8?B?U2RrYUJ5cU9HUUs4NzZSalgxRGN4V2s0U055Q0RqaFVZNm0zcVlZc0RaK01s?=
 =?utf-8?B?RlBNaFBFTzRpOFJZbHVveDF4cTJxK3dmR1EwRTNxMllPL1Fvc0tVQSt2d3ZL?=
 =?utf-8?B?cG0xVWJGbHM5V2l0QWxOZUxmbnhVR1B0OGErWHZRRkoxM2FvVzF5bzNJUEps?=
 =?utf-8?B?bElQcnpaTWlUMDl6cU1leWlwOVVpdlJuVy94NE1uL24rOXVwRTYyMTQ2SHM0?=
 =?utf-8?B?WnRjb1Y0c2xPK0RWTGFZRlJCVHQ2bXlLTjZLc0Y4S1B3Zkc1RjVpRThObXQy?=
 =?utf-8?B?bFhFRCtQMmZ3dFBpeWhOblFlVElXWU5BMUxaQS9CQnF1a1RncnZEYWxXMlpL?=
 =?utf-8?B?NEU4ZmhwUzlYaHNVdVBkS0I3RjFYWm9XaVJlaDZmRTZ2OWZBaGdqbklsTW9V?=
 =?utf-8?B?NVQzL1BUMWZhNmdIeldJUGo5Ymc2S3BydmUrZXNYK2tnK09aTU1Lc2dtRjlx?=
 =?utf-8?B?UDMreTh6UHN0a2pxSGorTElVU2k4MGs5WU5ZSVhHKzJZK205UUJFaDd0UlBQ?=
 =?utf-8?B?TEF6QUlMcU5lTmhZd1JydDdUSlMwbnhZaEVkRUppdXZCVElyV0cxa1FMZmQr?=
 =?utf-8?B?dW96Tk5GV1NGMU1Md09PRjI4NlFHYlA5QzBHSFU0Qm55MmtIaGNQNU8vamxU?=
 =?utf-8?B?d1IzaXhaWS8xaWpTWk5DRTdtVVBVU21uR2RNMEg4ZUxnTVhNMkdoV2QrTUlY?=
 =?utf-8?B?K2VpR0dFbkVKN05TWjNFbytIQm9IcDdzN3dJMDlCWXZrelhGVzF5YUJsdUYz?=
 =?utf-8?B?bjVubnRkYVpyeWMxQStZMVVlVHR1cEorMVRPQk1NdkJEZVR5Nzg0TXlhbzJZ?=
 =?utf-8?B?UkxWRTRQMENMV1lZd1Z0RTEwUC9FV2VSZ0NiU2dvZXFDT0RCeWdFbkxTRlow?=
 =?utf-8?B?aVUxRFJtWDRScmtUU3laaWZYN2cvcVJIWmw3UEx4NVZubFlsczhuc0RFckk2?=
 =?utf-8?Q?oAdChVk3MMzaKCKE=3D?=
X-Exchange-RoutingPolicyChecked: mA4l7++PuI9yRirruE8RyfeMDyx0MGK7pF/k3QBG3MDW5uHeRbXgVy7btG1LnPIkEs4IGIV+RLEwJ7Op7+hxJZjIPi/6DkKJNxiD0zpo+ktQPM4pxViJ7HO3kdgpBznK0S1d7CLzv8X/eBn7XyqhWKd2FLdGj7AhsaOU0uV85zVsQotVKCwGN/ffcImWr+jFU4KhO5bfGt77sxsfNcvPI8jW/6H+GBZvcql6kXVUUtlmkqn5ffXTLBH1ITvVKIYuJc7ZHA7elm+9WwfHbs9X2pZch3sjlfdsCTaiPtkTZ/6b+79ZNlseFKDpVjNtPecuVQY1AXhzGg4QsVwV6L5R2w==
X-MS-Exchange-CrossTenant-Network-Message-Id: 497458c2-c680-4e4e-a6d1-08df1f105e10
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB5035.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 16:32:13.5032
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6kVaKKHmrjVNZGwrHeVVjcNBEmnPefdQjrCosNosEIChEmB0kLv9vbWVb/vrgQLxKC9nlaR8B74btZ6KScBFhz3MbmYM/X8leVDSZYRNqww=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5808
X-OriginatorOrg: intel.com

Hello Neil,

On 9/5/2026 3:18 AM, NeilBrown wrote:
> From: NeilBrown <neil@brown.name>
> 
> DCACHE_PAR_LOOKUP acts like a lock in that threads can block waiting for
> it to clear.  As we plan to make changes to lock order for this lock,
> teach lockdep to monitor it so as to help detect bugs early.
> 
> As NFS allocates an in-lookup dentry to unlink a silly-renamed file, and
> completes the lookup in a different thread, we need interfaces to
> release and the acquire ownership of the lock.  This avoids lockdep
> complaining that a lock is still held on return to user-space.
> 

This seems to be causing regression in our linux-next CI [1] since
next-20260928.

<4>[   10.773931] ======================================================
<4>[   10.780181] WARNING: possible circular locking dependency detected
<4>[   10.786407] 7.3.0-rc5-next-20260928-next-20260928-g6375e61c01e9+ 
#1 Not tainted
<4>[   10.793773] ------------------------------------------------------
<4>[   10.800017] podman/794 is trying to acquire lock:
<4>[   10.804801] ffff888133cb8388 
(&type->i_mutex_dir_key#3){++++}-{4:4}, at: lookup_slow+0x31/0x60
<4>[   10.814849]
                   but task is already holding lock:
<4>[   10.820743] ffff88812dbd3048 (DCACHE_PAR_LOOKUP){+.+.}-{0:0}, at: 
__d_alloc_parallel+0x53a/0x920
<4>[   10.830976]
                   which lock already depends on the new lock.

Detailed log can be seen found in [2].

We confirmed that reverting the patch solves the issue.

Could you please check why the patch causes this regression and provide
a fix if necessary?

Regards
Chaitanya

[1] https://intel-gfx-ci.01.org/tree/linux-next/combined-alt.html?
[2] 
https://intel-gfx-ci.01.org/tree/linux-next/next-20260928/bat-arls-6/boot0.txt

--Bisect Logs--

git bisect start
# status: waiting for both good and bad commits
# bad: [6375e61c01e93e35ee7acd336a689ac1fae4b509] Add linux-next 
specific files for 20260928
git bisect bad 6375e61c01e93e35ee7acd336a689ac1fae4b509
# status: waiting for good commit(s), bad commit known
# good: [5dad87615c9861cfa366ca984b52f581e861df20] tty: add break_wait 
kernel-doc
git bisect good 5dad87615c9861cfa366ca984b52f581e861df20
# bad: [3bd2d86b7cc084d0a610760cfa40349497ea8920] Merge branch 
'for-next' of https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git
git bisect bad 3bd2d86b7cc084d0a610760cfa40349497ea8920
# good: [3cc80c8dbcd8475e98ae86759750d0a140b063fd] Merge branch 
'for-next' of 
https://git.kernel.org/pub/scm/linux/kernel/git/gclement/mvebu.git
git bisect good 3cc80c8dbcd8475e98ae86759750d0a140b063fd
# bad: [3ac0b1643b3b216ce37d5ec4352fee8a01ecd37d] Merge branch 'fs-next' 
of linux-next
git bisect bad 3ac0b1643b3b216ce37d5ec4352fee8a01ecd37d
# good: [48a0400362e2648ba3ab56df8eceb782abfb7d17] Merge branch 
'for-next' of 
https://git.kernel.org/pub/scm/linux/kernel/git/geert/linux-m68k.git
git bisect good 48a0400362e2648ba3ab56df8eceb782abfb7d17
# good: [1ba62e451b02da61d4786a11da46501cd253cd2e] Merge branch 
'for-next' of 
https://git.kernel.org/pub/scm/linux/kernel/git/hubcap/linux.git
git bisect good 1ba62e451b02da61d4786a11da46501cd253cd2e
# bad: [b298f749884547ec4b746bdffc293fdd3b5a64ec] Merge branch 
'vfs-7.4.misc' into vfs.all
git bisect bad b298f749884547ec4b746bdffc293fdd3b5a64ec
# good: [cb70d8c361808b08d13dc4bdddb59cd92c48f84c] Merge branch 
'vfs-7.4.file' into vfs.all
git bisect good cb70d8c361808b08d13dc4bdddb59cd92c48f84c
# good: [d2b6b01e5969a762e92832cb6c9e2a470a842fcb] Merge branch 
'vfs-7.4.iomap' into vfs.all
git bisect good d2b6b01e5969a762e92832cb6c9e2a470a842fcb
# good: [a647a53bc89a046bee4a12a0a5627f2dfaaef807] dcache: report a 
Tasks-RCU quiescent state in dentry_kill()
git bisect good a647a53bc89a046bee4a12a0a5627f2dfaaef807
# good: [a2fb05f5133f83b2359b4b15d091bcf21e8b02bc] Merge patch series 
"kernfs: don't hold kernfs_rwsem across dir_emit()"
git bisect good a2fb05f5133f83b2359b4b15d091bcf21e8b02bc
# bad: [3879f51857325da9bf3cfb073280257cd16ae067] Merge patch series 
"VFS: prepare for changes to directory locking"
git bisect bad 3879f51857325da9bf3cfb073280257cd16ae067
# good: [17c7d109d8c9a6744b40ded06cc596cd6a80ec49] VFS: introduce 
d_alloc_trylock()
git bisect good 17c7d109d8c9a6744b40ded06cc596cd6a80ec49
# good: [cc47a1ba1983116ee7a720a79197eb5299ae5d31] VFS: Add 
LOOKUP_SHARED flag.
git bisect good cc47a1ba1983116ee7a720a79197eb5299ae5d31
# bad: [fd96e30426ff3e1352309ccf6843dc7fd9d38fde] VFS: reserve a d_flags 
bit for fs-specific usage
git bisect bad fd96e30426ff3e1352309ccf6843dc7fd9d38fde
# bad: [59492f9991dc19d5cc2c34295f1403d0f211e734] VFS: add lockdep 
monitoring of DCACHE_PAR_LOOKUP lock.
git bisect bad 59492f9991dc19d5cc2c34295f1403d0f211e734
# first bad commit: [59492f9991dc19d5cc2c34295f1403d0f211e734] VFS: add 
lockdep monitoring of DCACHE_PAR_LOOKUP lock.


> Signed-off-by: NeilBrown <neil@brown.name>
> ---
>   fs/dcache.c            | 15 +++++++++++++++
>   fs/nfs/unlink.c        |  3 +++
>   include/linux/dcache.h | 32 ++++++++++++++++++++++++++++++++
>   3 files changed, 50 insertions(+)
> 
> diff --git a/fs/dcache.c b/fs/dcache.c
> index cbd5738de168..83790c7a4dee 100644
> --- a/fs/dcache.c
> +++ b/fs/dcache.c
> @@ -1901,6 +1901,7 @@ EXPORT_SYMBOL(d_invalidate);
>    
>   static struct dentry *__d_alloc(struct super_block *sb, const struct qstr *name)
>   {
> +	static struct lock_class_key __lookup_key;
>   	struct dentry *dentry;
>   	char *dname;
>   	int err;
> @@ -1958,6 +1959,8 @@ static struct dentry *__d_alloc(struct super_block *sb, const struct qstr *name)
>   	dentry->waiters = NULL;
>   	INIT_HLIST_NODE(&dentry->d_sib);
>   
> +	lockdep_init_map(&dentry->lookup_map, "DCACHE_PAR_LOOKUP", &__lookup_key, 0);
> +
>   	if (dentry->d_op && dentry->d_op->d_init) {
>   		err = dentry->d_op->d_init(dentry);
>   		if (err) {
> @@ -2037,6 +2040,7 @@ struct dentry *d_duplicate(struct dentry *dentry)
>   		return ERR_PTR(-ENOMEM);
>   
>   	new->d_flags |= DCACHE_PAR_LOOKUP;
> +	lock_map_acquire_try(&new->lookup_map);
>   	spin_lock(&parent->d_lock);
>   	new->d_parent = dget_dlock(parent);
>   	hlist_add_head(&new->d_sib, &parent->d_children);
> @@ -2801,6 +2805,15 @@ static inline void end_dir_add(struct inode *dir, unsigned int n)
>   static void d_wait_lookup(struct dentry *dentry)
>   {
>   	if (likely(d_in_lookup(dentry))) {
> +		/*
> +		 * Tell lockdep we will wait for the lookup lock, after
> +		 * dropping ->d_lock, but won't actually take it.
> +		 */
> +		spin_release(&dentry->d_lock.dep_map, _THIS_IP_);
> +		lock_map_acquire(&dentry->lookup_map);
> +		lock_map_release(&dentry->lookup_map);
> +		spin_acquire(&dentry->d_lock.dep_map, 0, 1, _THIS_IP_);
> +
>   		dentry->d_flags |= DCACHE_LOOKUP_WAITERS;
>   		wait_var_event_spinlock(&dentry->d_flags,
>   					!d_in_lookup(dentry),
> @@ -2923,6 +2936,7 @@ struct dentry *__d_alloc_parallel(struct dentry *parent,
>   	}
>   	hlist_bl_add_head(&new->d_in_lookup_hash, b);
>   	hlist_bl_unlock(b);
> +	lock_map_acquire_try(&new->lookup_map);
>   	return new;
>   mismatch:
>   	spin_unlock(&dentry->d_lock);
> @@ -3021,6 +3035,7 @@ static void __d_lookup_unhash(struct dentry *dentry)
>   	b = in_lookup_hash(dentry->d_parent, dentry->d_name.hash);
>   	hlist_bl_lock(b);
>   	dentry->d_flags &= ~DCACHE_PAR_LOOKUP;
> +	lock_map_release(&dentry->lookup_map);
>   	__hlist_bl_del(&dentry->d_in_lookup_hash);
>   	hlist_bl_unlock(b);
>   	dentry->waiters = NULL;
> diff --git a/fs/nfs/unlink.c b/fs/nfs/unlink.c
> index b57cfaa4d516..c8d712204e64 100644
> --- a/fs/nfs/unlink.c
> +++ b/fs/nfs/unlink.c
> @@ -67,6 +67,7 @@ static void nfs_async_unlink_release(void *calldata)
>   	struct super_block *sb = dentry->d_sb;
>   
>   	up_read_non_owner(&NFS_I(d_inode(dentry->d_parent))->rmdir_sem);
> +	d_lookup_acquire(dentry);
>   	d_lookup_done(dentry);
>   	nfs_free_unlinkdata(data);
>   	dput(dentry);
> @@ -159,6 +160,8 @@ static int nfs_call_unlink(struct dentry *dentry, struct inode *inode, struct nf
>   		return ret;
>   	}
>   	data->dentry = alias;
> +	d_lookup_release(alias);
> +
>   	nfs_do_call_unlink(inode, data);
>   	return 1;
>   }
> diff --git a/include/linux/dcache.h b/include/linux/dcache.h
> index 2b7d99ec9306..e7e3ef05313b 100644
> --- a/include/linux/dcache.h
> +++ b/include/linux/dcache.h
> @@ -116,6 +116,8 @@ struct dentry {
>   					 * possible!
>   					 */
>   
> +	/* lockdep tracking of DCACHE_PAR_LOOKUP locks */
> +	struct lockdep_map		lookup_map;
>   	struct list_head d_lru;		/* LRU list */
>   	struct hlist_node d_sib;	/* child of parent list */
>   	struct hlist_head d_children;	/* our children */
> @@ -554,6 +556,36 @@ static inline int simple_positive(const struct dentry *dentry)
>   
>   unsigned long vfs_pressure_ratio(unsigned long val);
>   
> +/**
> + * d_lookup_release - release ownership of DCACHE_PAR_LOOKUP lock
> + * @dentry: dentry that is locked
> + *
> + * If an in-lookup dentry is to be passed to another thread which
> + * will drop the in-lookup lock, then d_lookup_release() must be called
> + * to tell lockdep that this thread no lock holds the lock.  The
> + * thread that receives the lock must call d_lookup_acquire() to
> + * acquire the lock.
> + */
> +static inline void d_lookup_release(struct dentry *dentry)
> +{
> +	if (d_in_lookup(dentry))
> +		lock_map_release(&dentry->lookup_map);
> +}
> +
> +/**
> + * d_lookup_acquire - acquire ownership of DCACHE_PAR_LOOKUP lock
> + * @dentry: dentry that is locked
> + *
> + * If an in-lookup dentry was passed to this thread, the
> + * d_lookup_acquire() must be called to tell lockdep that this
> + * thread now owns the DCACHE_PAR_LOOKUP lock.
> + */
> +static inline void d_lookup_acquire(struct dentry *dentry)
> +{
> +	if (d_in_lookup(dentry))
> +		lock_map_acquire_try(&dentry->lookup_map);
> +}
> +
>   /**
>    * d_inode - Get the actual inode of this dentry
>    * @dentry: The dentry to query

