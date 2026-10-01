Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4E603D5673;
	Thu,  1 Oct 2026 10:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790851197; cv=fail; b=ANrDZmJ7ROsjmdOdpxNbApclA6hQ9NLE7kfiQJvGlMiX0lZ7qyCNxuzA6S0vc374S2dQAnqF+qpvK4p50mnl9FfYw7HTNG+AbyWhwHstDBR32JhQtRdUDpD4bPmS7rQb6TThucI/nf1u6jRt87S2pRSsA546pe0CM7bzdqdWJx4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790851197; c=relaxed/simple;
	bh=Rna6G5YifOygjQuVWoIoxPymGIp1iJm9/O8jACczwtA=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FitmaZKqOo7ydvEXxs32LudjNxRgPQ9tl2vG7P2OF+vZfplfKmRARNVAmXSBPzMzmvidtU+mgzy6Ilhau5Au37U9UXdmF0Tgp1HvmqkDOhhFE2Ysy9jq2bsSsyx4EmXfAwMwrZT8wrO4XstPeZcF6YCYh0QT/hRdYazMOCowlOU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M1JOBHXk; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M1JOBHXk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790851193; x=1822387193;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Rna6G5YifOygjQuVWoIoxPymGIp1iJm9/O8jACczwtA=;
  b=M1JOBHXk6Th3Xjbi9kQeT6e4OGfQfzVRux05W7uHhdVv8129Z8rqNSdk
   yKLO3EvFDIi2jZs+BO6Mq7Ix1BHVJ3DV41D+CfBg8VC9EObhSOO2t1c7f
   CAoDbbSVK7M/Lw6nS3m9zvTTuq9ep555we8N/iZPWh18oacu9e1hUMzeb
   U1eIEKAUh5Ih6/WvKq+sXBf4Zuq2XfvF+lnvTk5+88lEXGYtDN4b2Nd6n
   egZ1Zi8/D84atZv2P+B0lRsafU/ofn8L0fJ3kkYaTbMWl7IdHuZbNxBwf
   3Jduk1o8k2xq7s8D3F2rqAfi0H4dkFM2C2mMgWP+tGIfiGzZuBKhJZa9u
   w==;
X-CSE-ConnectionGUID: DszoVhTAQMWHVZYI5CAeig==
X-CSE-MsgGUID: O/MyIj3ORh6w7WgckXZqoQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11921"; a="102127443"
X-IronPort-AV: E=Sophos;i="6.27,134,1787036400"; 
   d="scan'208";a="102127443"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2026 03:39:49 -0700
X-CSE-ConnectionGUID: FhiP3ZLJQTSWhaV+96kTyQ==
X-CSE-MsgGUID: 4Bl4wxIiSbqrmZJryF8w8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,134,1787036400"; 
   d="scan'208";a="272388702"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2026 03:39:49 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 1 Oct 2026 03:39:48 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Thu, 1 Oct 2026 03:39:48 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.68) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 1 Oct 2026 03:39:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TSxV2yAGMFcGMjZ5XeMt+g/vjpGWTSgqJKlkvs72nRc2n8bkftF49YmTKe6iHc/0KZe7L9QysueJyHWkO/8pWLH5SmMikjErWXkw/FODEnSkcRbqagl+8U37S8P1mCrZDxvrKIpyWlsY5+oqa2cex7ToH6DFCWHnPYJ6TGCxo0hn6qxMMBrG/XLQEPZR/5/A3DdmB4JeVE9timM3KquZyp6Gy3YCYjtliIjLLlP/icmtdcWRwVpQzTpWMQgDELCNb2DM152ndAKVEbM8ZN0PK0zaBqYcVCTEpgZu3OUx5E6U/UjNE5g5KERdhln6Zm3jQpM94Qy+0HJ0dNrjGDndIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LzujqB/9FR9JtKNO1IASKeall+S/UsytAq9FzAiByEw=;
 b=NCXFzlGmGIlKyny6NJ3bBXZvsah0tN4rL8S1Pkq9yaXp9kIPcPNMJRXhwFooWVPg4rzDm62BzR6vIeHCKfDj/Zb7KFXMIqZipmYNz/b6De2/dzDMy56qLBi9NNIT1GViEMt1yvVcm7U4DYK7JrcQvVy4cGT0P0Ltclap17LBTxljMHMUVOra6BmeMuO4lS3CRBKU8b9tLPjKUCNIio4g8/7XT3b2153hNXqSlKkQc2g0bb3TJMEMf4FYRlEGGDUIu1reRTf1q0g8xMJnasUNt/JZ0IFNLt3ioM3RW9LvchBwm/ThFNK1z64pagUNI9vqYNnrmf6o51EggYtVmacmgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA2PR11MB5035.namprd11.prod.outlook.com (2603:10b6:806:116::21)
 by CY8PR11MB7084.namprd11.prod.outlook.com (2603:10b6:930:50::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.26; Thu, 1 Oct
 2026 10:39:46 +0000
Received: from SA2PR11MB5035.namprd11.prod.outlook.com
 ([fe80::9418:cd60:8ece:69c3]) by SA2PR11MB5035.namprd11.prod.outlook.com
 ([fe80::9418:cd60:8ece:69c3%5]) with mapi id 15.21.0472.015; Thu, 1 Oct 2026
 10:39:46 +0000
Message-ID: <f758f351-573a-43d6-81d7-4312ccf54c1f@intel.com>
Date: Thu, 1 Oct 2026 16:09:26 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 6/7] VFS: add lockdep monitoring of DCACHE_PAR_LOOKUP
 lock.
To: NeilBrown <neil@brown.name>
CC: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner
	<brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	<linux-fsdevel@vger.kernel.org>, Jeff Layton <jlayton@kernel.org>, "Amir
 Goldstein" <amir73il@gmail.com>, Miklos Szeredi <miklos@szeredi.hu>,
	<linux-kernel@vger.kernel.org>, <ravitejax.veesam@intel.com>,
	"intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
	"intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>
References: <20260904215142.1060510-1-neilb@ownmail.net>
 <20260904215142.1060510-7-neilb@ownmail.net>
 <e3772a51-eabc-4c31-b73d-f3187bf1b3b2@intel.com>
 <179080249491.37859.6519131410483661870@noble.neil.brown.name>
Content-Language: en-GB
From: "Borah, Chaitanya Kumar" <chaitanya.kumar.borah@intel.com>
In-Reply-To: <179080249491.37859.6519131410483661870@noble.neil.brown.name>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0126.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1d0::7) To SA2PR11MB5035.namprd11.prod.outlook.com
 (2603:10b6:806:116::21)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PR11MB5035:EE_|CY8PR11MB7084:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a64b5fd-19b2-4f96-ab7d-08df1fa84f68
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|23010399003|7416014|366016|4143699003|11063799006|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: ERJiUK3SuNhgta3aHoBahr+XId/+Gu6GTmasija9ZznzHGRsgZFxDuAQyESfloyAQF/45gQhTWYmCi8OMq1/ngE8QI620urqvWukwMnVuUqSh9WeuqhzGQeHKeMaVhFmAqc2StU8byM7Edg2NJuwC8Fvx5SkAmcZkhFvb11Qf624akcdvV1n8BhCCJnVtxLzmbhqzAtgCv+pMEcgcaZak/E/cpc885RVNBCFKPmyCBlr5ipOPo0eurHrRQ/yqagABo2XHIa1zRbYbynxJElMw0C7xa9pB7SIeIfCxqUfyNHfazLBB5dp66A9qUyQVw/ftvZt2nxn26Sj1YYLz9BrdKTxSEqiOSQG1QtnFOsY4OyJnrB1HWtyjPm0uMFiD6+59nu3ar11ZsDypbPxnqc+cXs+mfz/N5hBE+ARJo8BtWxSXwZtqMxdSs1pRP0L7YiC5sWTMpu5dDGdxftkxbxWK12XAbZu1GOQeShpPLqysYZjBSNj9AZZaVCcz3GWQJgDi98ZPUNpQqpCq51lXDh3YaGlnfWvkf7SKFl5Eya2glmXn4e83lLaryk/9T/W85+mJQarije1+cxQYdoNoqWQMq3hvJmMy1Cdpdz2UOVIIQ5iinGpqh+3AU1k7o4PW+e2
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB5035.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(7416014)(366016)(4143699003)(11063799006)(56012099006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cDAxaFRGMGd0SmIyUUdCeUtUeE9BYlVMaDJvQUpIR05EWlZoa2J2Z1NrUGFC?=
 =?utf-8?B?VHNrcG9UOCs5WGNoYXE1anJKNW9JaytxaC9kdFh3VlgrQ3pCaVp0cjJZSGc2?=
 =?utf-8?B?QnpqNTlTTVEyamZqV0xzVEpkVVNUQVh3WG1qdCtOUEN2STYyeG5xSk5JSzlU?=
 =?utf-8?B?QmgxSnk2NVhpREk0UUY0NEZaY0UyNkJqYkExSlpYcVFnOUUzUVpESFJNbGhV?=
 =?utf-8?B?amRCMlpuKzV4VVZ1aDIrMkVILzFwNnRQc0tCVEtBL2RaTVcyMnZUSVlFK3Y1?=
 =?utf-8?B?RzhQWkpiZkdPMlVLdTZxY21hNjEwa0tHK0Urb2YvejFzN3VCaG00VU5uWlZI?=
 =?utf-8?B?aXYrZEdSVlFINUlPaDNaM2hQTWg3ODFGMXMxUytNeE5FdWMvdmp5NEpEK3Bw?=
 =?utf-8?B?YzhzbDIzSW93NWQ2VUlCWkNwcFZyTUp2SU9DUWN6QnpWUnQ2ekZQY3pJTmRr?=
 =?utf-8?B?aHpxa200UXZZeHByYUVXaGk5d1lTSldHUDRhZDFpU2FlNFl2cEtuSDRvcUM2?=
 =?utf-8?B?ZnQ3L1RJbEU1NmgweUZwVE8zTTRWbFYvOXJvbXBIQ1NtOE9od3U3Qll4cExr?=
 =?utf-8?B?ay8rNGEvUlhzKzdJd205b3U0b0VhZm9lZi9RMXM2RVowT1hwK3AvYjVrNU1u?=
 =?utf-8?B?TVJLbmhad0dqVVJleFNYRUIwODRld2ZXaHdlQ3JnTXhlcDNuSC9aNDkzOXpF?=
 =?utf-8?B?SGN5aDhIcHJ1bjYwS0Nlam92dGFwckVrY0ZPei83dFUyc2pBY09pcVdBOXdN?=
 =?utf-8?B?TDAwSmtTRVl2YmVLYkdhcC8wYy8vYUJIY3d1clFqWnBKeG4yckxMNzVoR2tB?=
 =?utf-8?B?ZnA0QmVnbEM2ekU0YVIzWHAxYnc0U09RWnF5YnNXQjRkanQrbTU3SUluUllp?=
 =?utf-8?B?cFhOY0NZRHh4VEwwam9XZ0hWeDhMUnl2TVN1aWlCdlVqck8xVERaT3FhdXQz?=
 =?utf-8?B?eFVLZUVLTXdQYmc0OTdCYkZpQjcrZXNSYWNUREUzekJsMlhpcVpOdTFwSFN0?=
 =?utf-8?B?TjhZZzYwOFhmbEdtRUZSNEtNcnVra3VOdjhRQnV4N0ZxM2FyNDJDU2o3VnhF?=
 =?utf-8?B?M2NGYzlqdkJZWlNpTXhCelZ0NFlqTllRR2VpcmtuTmRkRW11bG1hK0tMYTBh?=
 =?utf-8?B?ekVESGV5NkFzY25GWGxNaUY0UDVnazZldktqVU1GVUlWMG9FU21yZldIVVE2?=
 =?utf-8?B?U0R2aUQxaEw3RGxtREE0WEJiU1g3V3NFMFdXcThHTXMrd2JtblNJWUJ4b2lC?=
 =?utf-8?B?SFBNYUllaHhMYkQxTXRLSVpmbWVCOWpqNDlkdVVtbU9EbndML2NJci9zL2w3?=
 =?utf-8?B?TXN1NU5FcWtzL054VjJGQUk0K05aN05JTit5dGRlRFJEMWxlZlE3Mk9rRk9w?=
 =?utf-8?B?a0wwNUtaRUZXQmlYVjlJUk5xOEQ3NmNyWnVOM2FLZ1Z0NzMzbWJXb2RmWkM4?=
 =?utf-8?B?UjJGVS9mcVpPWlY2eUIzU013aEhvcWw0SktzMDhRY2JXYXkrZ3gvNnVkVGt5?=
 =?utf-8?B?S3NONjFFMjhlR1FKOGErWkY4QzM5THdEOXA5U05PWW5pYTh4Y0RKSG9lSEVH?=
 =?utf-8?B?TkUyYmxCRHhEa0p5SWd0SUYxMHFGQ1YvWnJubTBScnArSEdNa0ZaSkNLN1hL?=
 =?utf-8?B?UzFiT3FBczF3YVdOYUp5b05Daml2bXJhNEN0Z1ZQODJ4U3Y3bWtNS09WR1Rs?=
 =?utf-8?B?bTFqeENma0djbE1xazVDeVY0eHNoWG5vcFR6WlkwZVllelhnRDd4VkgzRWpy?=
 =?utf-8?B?YlBYMEVzcGo5STNyOUE3bU1DL1ByamRPUXdyOEZwZEVqK3lBQ2haT0pFTmVv?=
 =?utf-8?B?VW9QL2xxY2xEVGttNGtKNEhEdkhWdUVJVU5sZUYzVmI3QmdOOVZhMlJXaWRL?=
 =?utf-8?B?MElPSjY1QW4wNzkxc2YwckdCRHZrNVhZaG1YZEY3cHNNT2l2ajFjNFV1NmJk?=
 =?utf-8?B?djJKZkc0S1lLR0dZL2YweDBqOXdxTUkvSjhDSTBhckdnMlJzTFBFWHpvTitz?=
 =?utf-8?B?ek8vL2pkREh0SlhSQ2Y2NWF4UTliNDd0QzIzTHNZVktuL01FUnFYWmZROU82?=
 =?utf-8?B?Z3piUGd3d3JWNitYRStuS3FlYllnTHdrYXoxV1c0TXJsNUh1blh5eGx2RDJ3?=
 =?utf-8?B?QnJOaE5IWit3Y09WMWNjOUNXdHpKNUVuNDRiNHZUR2JRWlZFZ2tWbysvTXFy?=
 =?utf-8?B?UHVFMjdvUmVMMUdFazd2cStJNnNnQTl3ZlFJUndEdElOUnF6Uk55MlNuNUpz?=
 =?utf-8?B?UHlrbkd4NzBJQkJOQ2YwR0RVNjNLSGxTNGJUQ1pRYWtUYkpoK1ZINWxacmEw?=
 =?utf-8?B?NlpxRDRjWnB3WmtWZHQrTWt4RzlOSDN5czlPcVlmL0oxWXFBUStYU1VZZ1R3?=
 =?utf-8?Q?EPGcQQBpjg6sZplg=3D?=
X-Exchange-RoutingPolicyChecked: hf9Ee238nFGtr+6FCP5oY+TpEt4F0oN3wyfuU45G712PDLtTibTeUDZyMw8AD+xCGQDK5PKUTiirCR8baGLXPK0K/oHBMAc8yra5Ci15QVg7kGFTikbvosAbJOLIU/y+KD4lf41be0nGWBsQ0bMxc8vS3ykY5Oyf1b6rsQdX/pb4ROuyi1Wyl3cR0GdyKZhe8cvNPs00+Cs9C8CvPUSpn/F6fPYvnEkfmNRx5+/732zCm1Q+Ef/ehsnjYSQzwMlvCCHbXxswC5/G2gYotmsO2oi3I1t+MCJSAhDd8jPenM94U4jCLb1pnL7Cj62jLaPCdAS08+ZVnBSJxCpzARuA7g==
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a64b5fd-19b2-4f96-ab7d-08df1fa84f68
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB5035.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 10:39:45.9256
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KSgb/yoDqDxYhOkNzHohh2ivC9K1yJWkuf0D1MDmKAmHGN6MepsH/hV1zV67TO7vepuHeOToMbQmGa84HCw3kvPlk0B3jdX1MScPoTFvc90=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7084
X-OriginatorOrg: intel.com



On 10/1/2026 2:38 AM, NeilBrown wrote:
> On Thu, 01 Oct 2026, Borah, Chaitanya Kumar wrote:
>> Hello Neil,
>>
>> On 9/5/2026 3:18 AM, NeilBrown wrote:
>>> From: NeilBrown <neil@brown.name>
>>>
>>> DCACHE_PAR_LOOKUP acts like a lock in that threads can block waiting for
>>> it to clear.  As we plan to make changes to lock order for this lock,
>>> teach lockdep to monitor it so as to help detect bugs early.
>>>
>>> As NFS allocates an in-lookup dentry to unlink a silly-renamed file, and
>>> completes the lookup in a different thread, we need interfaces to
>>> release and the acquire ownership of the lock.  This avoids lockdep
>>> complaining that a lock is still held on return to user-space.
>>>
>>
>> This seems to be causing regression in our linux-next CI [1] since
>> next-20260928.
>>
>> <4>[   10.773931] ======================================================
>> <4>[   10.780181] WARNING: possible circular locking dependency detected
>> <4>[   10.786407] 7.3.0-rc5-next-20260928-next-20260928-g6375e61c01e9+
>> #1 Not tainted
>> <4>[   10.793773] ------------------------------------------------------
>> <4>[   10.800017] podman/794 is trying to acquire lock:
>> <4>[   10.804801] ffff888133cb8388
>> (&type->i_mutex_dir_key#3){++++}-{4:4}, at: lookup_slow+0x31/0x60
>> <4>[   10.814849]
>>                     but task is already holding lock:
>> <4>[   10.820743] ffff88812dbd3048 (DCACHE_PAR_LOOKUP){+.+.}-{0:0}, at:
>> __d_alloc_parallel+0x53a/0x920
>> <4>[   10.830976]
>>                     which lock already depends on the new lock.
>>
>> Detailed log can be seen found in [2].
>>
>> We confirmed that reverting the patch solves the issue.
>>
>> Could you please check why the patch causes this regression and provide
>> a fix if necessary?
>>
>> Regards
>> Chaitanya
>>
>> [1] https://intel-gfx-ci.01.org/tree/linux-next/combined-alt.html?
>> [2]
>> https://intel-gfx-ci.01.org/tree/linux-next/next-20260928/bat-arls-6/boot0.txt
> 
> Thanks for the report!
> The log shows that overlayfs is involved.  overlayfs has special needs
> with respect to lock nesting which I hadn't allowed for.
> 
> I think this patch should fix it.  Please let me know.
> 

This works! Thank you. Hopefully it gets into linux-next soon.

Feel free to use

Tested-by: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>

> Thanks,
> NeilBrown
> 
> 
> diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
> index e487597337e8..e1448dd776b4 100644
> --- a/fs/overlayfs/super.c
> +++ b/fs/overlayfs/super.c
> @@ -163,10 +163,34 @@ static int ovl_dentry_weak_revalidate(struct dentry *dentry, unsigned int flags)
>   	return ovl_dentry_revalidate_common(dentry, flags, true);
>   }
>   
> +#ifdef CONFIG_LOCKDEP
> +#define OVL_MAX_NESTING FILESYSTEM_MAX_STACK_DEPTH
> +static int ovl_dentry_init(struct dentry *dentry)
> +{
> +	static struct lock_class_key ovl_d_lock_key[OVL_MAX_NESTING];
> +	int depth = dentry->d_sb->s_stack_depth - 1;
> +
> +	if (WARN_ON_ONCE(depth < 0 || depth >= OVL_MAX_NESTING))
> +		depth = 0;
> +
> +	/* Based on lockdep_set_class() */
> +	lockdep_init_map_type(&dentry->lookup_map, "DCACHE_PAR_LOOKUP_OVL",
> +			      &ovl_d_lock_key[depth], 0,
> +			      dentry->lookup_map.wait_type_inner,
> +			      dentry->lookup_map.wait_type_outer,
> +			      dentry->lookup_map.lock_type);
> +
> +	return 0;
> +}
> +#else
> +#define ovl_dentry_init NULL
> +#endif
> +
>   static const struct dentry_operations ovl_dentry_operations = {
>   	.d_real = ovl_d_real,
>   	.d_revalidate = ovl_dentry_revalidate,
>   	.d_weak_revalidate = ovl_dentry_weak_revalidate,
> +	.d_init = ovl_dentry_init,
>   };
>   
>   #if IS_ENABLED(CONFIG_UNICODE)
> @@ -176,6 +200,7 @@ static const struct dentry_operations ovl_dentry_ci_operations = {
>   	.d_weak_revalidate = ovl_dentry_weak_revalidate,
>   	.d_hash = generic_ci_d_hash,
>   	.d_compare = generic_ci_d_compare,
> +	.d_init = ovl_dentry_init,
>   };
>   #endif
>   

