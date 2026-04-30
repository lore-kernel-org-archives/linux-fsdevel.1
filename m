Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46DF240149B
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Apr 2026 11:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777550000; cv=fail; b=KO50qxQn/7IWtHymfscHy6HD6yMDGaN3Epsq5Jv4dvz+6azDo54Qtt7AgpJBu3xDz7dA1OF/PEs9ZnXlGxMdCPcpBaD8AZ2EkRwHYjT26bUO5vjnW2yHGLZU1QExy8/AEAx0cVxPcqGZlG3q6TrG11REVJ5e457wu3EQWDUtBLM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777550000; c=relaxed/simple;
	bh=XhNYGOT5/sAuvScIor7owlL20fbN+hufFjmzN+MJiEo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=m2mfyQzYi2tCt2H5Mkp4T/fTjo+fe4VAdzofHLk76lKQQeNEa0WubmstxQqeK1+mkgnQ4GSGzBCAu1RhEbJEf17LX9U0NcbR6KQu3NIwtfRL8XxWbVDiSrrL9bp/yueyukL0IPJDNTmEVT/FcuONTQYTVsHC2ftZ1izKSnNG4cQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=VpD1bif+; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=ysVYgp8V; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="VpD1bif+";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="ysVYgp8V"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1777549996; x=1809085996;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=XhNYGOT5/sAuvScIor7owlL20fbN+hufFjmzN+MJiEo=;
  b=VpD1bif+/jZt7HCS7wgojpNhcW0W0gTlTsgYcUxYrT2bbYwJEHUb2VI/
   HukSejiyh24OxMrUzFenQcGFXtYLiM8I92L8nRJgVfLcRr2sRU0eP2Pop
   LpOCu5Lh3Yfnj9kCqtnBVHIfIjuhbJAZjiV2ZBobs8a+QTjUYdWX6wJW0
   IYW8FhMuJZ9fEDIK3gFLTrv76N9HjLI8LkOmY6bPLaOmirnLQDjiTCUYV
   KfB7lxVTe0TtDDU912Q+fGosn8Xw0YeK84DI5mVxeKplUrVcl1kKBc1eW
   EsL7OPhTw4CYE2fz31wc7zTXAHBqEPJjTuqvXzkyeJ3+uLTlTgPcVvQfB
   Q==;
X-CSE-ConnectionGUID: 7VavyClTTgmzmz8MIVmYOA==
X-CSE-MsgGUID: oA34q3tXS96WcumkUGt8BQ==
X-IronPort-AV: E=Sophos;i="6.23,208,1770566400"; 
   d="scan'208";a="144483417"
Received: from mail-westus3azon11012056.outbound.protection.outlook.com (HELO PH8PR06CU001.outbound.protection.outlook.com) ([40.107.209.56])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Apr 2026 19:53:13 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bWAxXiITD9GkQSg1ubGNWkqxwFQelWucuN/NQsJmUywel0k1ISdnPosBnJgOiNcWsov16O91AaiBqGuyy6Z+ksho4ku9DU9xG2nvi5SardoTupbczPYQleqEs48dUuWZmOIZaJSv7C4W7/yNUA7tilvNcXRrWiS5NMh2T16m7cj43jcxUO1ySDjvTZr0/uJ0cUjEiQMhOh+p0GWkSKwlY4YXmfFeyr7HOyKrA9d/uw3WLi/L1Y+mXKfMrnuhQPJlXvVjAwXAtCwpzl8hdTaQex++6odpLxDQJUNXT5HKJJegIglQ5SsZpCzzXNYKKO7UY0MUEz61VDPrKj9VVBqjxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XhNYGOT5/sAuvScIor7owlL20fbN+hufFjmzN+MJiEo=;
 b=xtPiZY4DCJvzOM+pKl2N7bRKIwYKmL6CgD5yQmF61tP6Yvz0kGXLSWQe3e/7aH9JY//A/zI6Xn4Ymj8NgPo+LM+oNoCe1loD6dLvtXaoCRFhxGX3poI/8SMHqgp14VZZOzujmHX6SW7uFgPkH5cT4lYfi+WTA38E+n+/yWI1rlR8YZ4t/mrt7uH03TKcau7SdYluKLD7rnx5RgOO4UPks0Dx6PotyA0zIQTjjubARWklFN84D8WcBtSx1TaO+p6I+X/4bq/NktJWWTSfL9afqwDBPqYb2840XLoh3VSNgfof4GFAEbT8c/fQLDbHSaREI97r+bqJkFgqSTzl+izUvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XhNYGOT5/sAuvScIor7owlL20fbN+hufFjmzN+MJiEo=;
 b=ysVYgp8VHEwu6wmOdK1tL7CcIrpTIsbhvWWbEwdViAqky1wpqH2KnyhY8nfNAtFO2fmt3otaoqYYcceA5FdeP4Xh5/wbva8awcHCLnnd2L3q5S/gNlq/ClfgIgQRXeIbIHFUtVqo09f6rElY0941llMlHgjFkE9aEc2UJjkR0lw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
Received: from SA6PR04MB9447.namprd04.prod.outlook.com (2603:10b6:806:436::21)
 by BY5PR04MB6485.namprd04.prod.outlook.com (2603:10b6:a03:1d9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.22; Thu, 30 Apr
 2026 11:53:09 +0000
Received: from SA6PR04MB9447.namprd04.prod.outlook.com
 ([fe80::14c6:1c14:485f:1825]) by SA6PR04MB9447.namprd04.prod.outlook.com
 ([fe80::14c6:1c14:485f:1825%5]) with mapi id 15.20.9870.020; Thu, 30 Apr 2026
 11:52:56 +0000
Message-ID: <f6a6849c-bdbb-43a3-ab16-b6a2fc6193d6@wdc.com>
Date: Thu, 30 Apr 2026 13:52:52 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] zonefs: handle integer overflow in zonefs_fname_to_fno
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Naohiro Aota <naohiro.aota@wdc.com>, linux-fsdevel@vger.kernel.org,
 Alexey Dobriyan <adobriyan@gmail.com>
References: <20260429205815.810952-1-johannes.thumshirn@wdc.com>
 <6fde66d3-04a6-421a-b90d-0443f872b722@kernel.org>
Content-Language: en-US
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
In-Reply-To: <6fde66d3-04a6-421a-b90d-0443f872b722@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0020.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::7) To SA6PR04MB9447.namprd04.prod.outlook.com
 (2603:10b6:806:436::21)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA6PR04MB9447:EE_|BY5PR04MB6485:EE_
X-MS-Office365-Filtering-Correlation-Id: 98329149-0c38-4750-9732-08dea6af04e2
WDCIPOUTBOUND: EOP-TRUE
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|376014|1800799024|366016|19092799006|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	UzJWKY6mLUKpu3ls703Vg5ILFjXDzyB4YQZCE1sFpSwm7PRlgjknDkOINzAK6XbdYlU/RXeAjAFzBTXiLavwDie5bGNLMXPcl1+qZtc/5OoEHPlyaAxHjc4isEma+dmyQBv7oSjsHTDSuc3fy0hboPAQQjUWTVKhixzH4OUo4gg4jZKrT44iqNVQmgR1SYSigZwgu225a7OkwVS+7SMuWzZQrEu7N1nbjHb7cmbLTNvaqU9SjTEto64h/K3YDZHyRmPWgtqZjevYu3xJLJ65axe7+IGJMcWl7O6oTJbVBm4j3KglyptTuY88mlHbu+T4BfFyvK7QMG1oKvO6emYfPF8opZ3Gbxs7HG4TuuxMZfvLbE5XSCY6bNvCJl/XeAGPDN1/vsCqkga6pgEjAD12Edfdg4U01RltYjILw5Mxy+pm3HaQKICoNW+2xg/jvOHklyqrlsdNARdAgI6wUgxq1+hdjQfuy9nF0j/avRcWodh6LisDqGaTSevIDLnFC0J+1o/bSw6wAp/T0tHdiFjCCL9DoXzz+I7girxno1Gx3xNUA4NplXItZYlOXRTwOFVAm7eF0q8jQJ4FqUYNaQ8DBuYrEqZUg9wI2iIYhytZxHkBbMxGqFX+S4dKQvuxLN2b9ny/WKYCN3FGodQHfSab4jxNH80x+rngrH3tcE5LTLr8/amTv97Jxmeg39dydpNwK0iDLsJ1nTFCapHlo1UPmQZMsKylZgQV+/MmFvyV3G0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA6PR04MB9447.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(1800799024)(366016)(19092799006)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RktVb3k5czV1ci81Z0hFd3lRdWExYkpGaVlZSTJlUlhMK1BkTzlQVkc1VCtJ?=
 =?utf-8?B?UkxNb3JaV0VxbmFWd1VoUFpQV2FRZFdKbVhtYnRoKzdpWlNDRXlZQ3I4dWlI?=
 =?utf-8?B?aVBIOGtGTWZaTkxpeEkrQ2FWcU1HZklWVXJPTWtSQTd3QUZRSVA1NjFlUVo1?=
 =?utf-8?B?VFJFUGlLQ25ldFA1OVJ3RzNBbUpWVGN2Rm81NVJ3bkJ2bnlPN1oyNkc2MEdP?=
 =?utf-8?B?WldGLzI2c2QycUlDcGlzYVlSaVBqSU5SdFNuMjl4RGFCNE92N3lDekdCbFdq?=
 =?utf-8?B?QVg3WkdWdUNvRTNPNE50NlRDUzNpQWNLT1BYM0dRQlVZbVlCY3haUmlPQ0xu?=
 =?utf-8?B?bG9rbzJBMnZYVTBGTUZLQmN6S1RQcEdpTHIxUFJvQjdLVjJ0V0l5dUtsWThY?=
 =?utf-8?B?TVkwVzFsUHdUb202QkZQSFUzMHk1TG5nRlczY3BzWmNVM01GUWxUaXExZHVv?=
 =?utf-8?B?NFd1N3pLRWhtZTg0dnFDTzVzZjZvcUxmbWJrcVFvNm8waUEyY2d4L09Uanl6?=
 =?utf-8?B?aWxYVGdLMGFyeUpBakxSSS8wVFY2dUkxNTBsUWhjNjIxam40MVFxaUNhRXhm?=
 =?utf-8?B?c3F0ei9Qd21zdUFuamdMQnpWcWhjMUcyZ1Fac2JiU05qSHBrek1vVS9OUXdG?=
 =?utf-8?B?RXhtWHAzbG9yQlA1MWcyZ2txZGtYQThHcGFIMmZTT2t4b2JELzYzUVNjMVRn?=
 =?utf-8?B?TE5Fd09YQ1R2N0FVcXpwZitxc1FJaHRLS3EwUDE2SjJ5dEVmaFR1akE4ck5r?=
 =?utf-8?B?dVBuZkFjYW55MkJ6YzJCOVk3VHVwT0EwUjI5ZjF3TXRISnYzME5pbkE1ZDFj?=
 =?utf-8?B?dGxHOEhOM3FwUjNJT2Z0dnY1MnJGQ3pSdWVCK29xY1J1TTF2ZGNLWk9iby9z?=
 =?utf-8?B?ODRzUXppQk5MUER4cDhBQkxoT2ZvNWN1dEg4dHlMZ09aUEZIdVlwcVg0a3ZI?=
 =?utf-8?B?V2pLYnVoZ0NQZjZHeG9xV2dVMGFZUks5WTdMcU4ybFVCN3ppa1U4Z1hlLzY2?=
 =?utf-8?B?bnp3N3dKajYyTysvWE1WdzVoUnlzNVJhbWxveFNrOG5ycGkrQ1FhQmZpalBO?=
 =?utf-8?B?L1htRzFybC8yeXZ1d2JEdTNQdDlOa2U3clBrMEd4cnVybXdtZUl5VjBxcmhL?=
 =?utf-8?B?L1h3U2QvdWlCeE85M25nNzdiSUkyUXkvaUlSOUxoSjFIT1craG4rbjJtcFRY?=
 =?utf-8?B?NnJRMlUzUW9qUVlSWVorNHdvaHNzb29GYUVGaDgwc0NzYUNwb0NKdnNscjVh?=
 =?utf-8?B?RzJVN0l4S0JTa2VxU3JqelBtSnNwcUdDUzBtelJaT09Cam5mSEJ4VDltSk14?=
 =?utf-8?B?Z0R6clE1YWVMeS9NVm5pbm9qVnNZSFBtUDRGbWoyU2xlZkhnREllU2tCdXZ4?=
 =?utf-8?B?QVh6ekNKYW1MeHRGVzIwNVlXMk9jdmdyYzFsQkpzOUZML2xUa2lFdi9MZmxF?=
 =?utf-8?B?S2pIRWxNTUJYODVGRXc3TE5RQ3JLWFAyV05iWHVRemxlYzZPN3YrQXAvd2M1?=
 =?utf-8?B?cFJoc1BjV2N4OXR2emg1MHE5alQyWGpyL1M1WnFXSTRzd2NxbU05ajNPTS9a?=
 =?utf-8?B?WTdPSE9VUXVCQzIwWFUwa3NGM3M3Vm5KK041M2dhV0N6dFdEQlNnU2tHMnlm?=
 =?utf-8?B?Ti93KzdDL3FVNVRDZml3YWFZRkVTckd0Q2d3NlJOMHByUEw4NjNzVTh1R1l5?=
 =?utf-8?B?VnV0VjRxaEFLQ3lrVVpFbnlOd283enVDWG10R1pQMllKdFVsRFBtRTM3RkZT?=
 =?utf-8?B?Z2UwZElaejhueWtlVm5aLzZyTmVpSmZaVlJnSzc4T1o5RWVHUGNUR1p3Y1VM?=
 =?utf-8?B?VGwxYU5wNkU4MlhXY0FnVXJoNDR0aVhxblV0NnJRUjcrajdxamRiM2hxVzhT?=
 =?utf-8?B?MXZBUVc4U0lvWXNFbE1PdVZ1c0NLNkhPbE5CbHZrQ2Q5STFDMWZwQVlRVlh6?=
 =?utf-8?B?clZOSC9GS3FiMmxET3ZkdnVIc0dlWkRQTHAzcXZobFhTZHVQVEdXUnRoaC9w?=
 =?utf-8?B?M1VNTytTUWlZcmtpMEpwb3dDeVhLY1prdmJQaHAwaE44cUxvVlFaczYyWjlk?=
 =?utf-8?B?MjluT1VVMGQrdmIraWIvZFpLck1pamdqUXdSaHpydFI5WXA1QXpMR09ISVFI?=
 =?utf-8?B?b1RvY2ZYTVR0MHRnWWVEdEJRTFA0WmtnNGRwWWkwOWt0OFZ6OFU3V2pjNHlv?=
 =?utf-8?B?amdnNjVGYmpVclNZSWI4RWZ4aEZHUTVwalhobVB3RktJZHQ1NzZIUU8wUmhZ?=
 =?utf-8?B?M3NhZUZUYnlZTFkxMlVwL3lsL2tnR3FMRGlzaGxna3BqZ2k1bzBLUWF3RUYx?=
 =?utf-8?B?ZDFFSzl6VHNMYUVzTEdQdlNHa2R5N2dmSElqRUhnSEZQNEFFb01JMEVuVnpS?=
 =?utf-8?Q?GfYBzK1UMRz6yqvSqK49Iig3CATvihv5ouMbuvv7reY5R?=
X-MS-Exchange-AntiSpam-MessageData-1: 7l5iSLNQBJrUBwQdvOZBbrP7S9dx9h90PUk=
X-Exchange-RoutingPolicyChecked:
	iHIjqm+rtISb0OlO2Iuv0hGxg8c6M3d4TZYzG5fL1bskWHv70JWAC12/GzFCEDoJXM2ctAOPUiyHgP7vX5UTh1U7gnTulZZDmzh/dn/9EUKSsIMI4NbJpkiLQuc1lyMmgMJeLxp+NigN0wut1hoPYpwJjNBoaSb4fc35h5JjI5uINS08n4YGAnPWCK1/sLY+e0JrNas1W1fbRyVNjCCywV70+GZmo8/QAykEvj64DvAssyNHvd1/ieRQ3UZ85RGfxnsYXcb9L3geB6k+4kftrPK2YsZkaTYy8/36o6RWPPYHglvT6x5AI9YKFuNG+3JycdVkhc7SX2/AQZqsdnjPYg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	1+cZcmusiLFuIDUJtkqzJrfMVzuaHG6GFbDqS3SyceStNZlUhIrQBpCBzHjkMvEXDbOX6SbqUKvb3eHiay4mtm9mdlBv2ikw7N8afWvMWVZC1WK2Y0wnXidcnh6JB31eFLvcM8FDBjjo065f45cHMbgZIb3MRTfu5Ncul6Lb0U9JzPEnixjmD1g5IcXnwMnlS2VKAU5+aj3NxU7kS1m768K6SU/kAZejPom5Y0JmAsJZYEgrum/W2y1zqrrCid7I6wk1oF5zdfPm5eBU2bAwxVG1muLdtm9+LHzggJCQlDU/PRJIoD6mCGY8pGLjjun71oTiVcuAdvaNuV05XRh4DkqcEHgIyxC3FhTf0yV74LTE7WARz/yGzxyrPPR6EdlWu8Gy10/j2Mrysj7IsvH/VKVP1ITkOm8S5sg4IGy1MjCZtNQ4oMfR77wTjEKqVgCg0wUjZpavAJ2gmuSALW4a18xlfJW3lV336bQX83/ZgQh4cnNG3nbCQbHuadCKpCgpNjMh/bNteXiTwHraOMXU11hAl2ai7ki6211qxNGevj2N9rslzDPEeP9WqQ5oyLesLrFP2LF8HHCzm7KidPS6LupPhZjVo4ze4/lw+ZUt+JqzlICsFu7RIlLDpu97ryZV
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98329149-0c38-4750-9732-08dea6af04e2
X-MS-Exchange-CrossTenant-AuthSource: SA6PR04MB9447.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 11:52:56.7152
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gDRaRZStC4+VSjxblPGqR6MUP6wmP69dCKqS39S3rgk6E3aS1FA9dp/otQr0M9To9VQ3cGrKCCw9vrPOVtob60b+FnXcQpNUfaYD8+OdL88=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6485

On 4/30/26 12:41 AM, Damien Le Moal wrote:
> On 4/30/26 05:58, Johannes Thumshirn wrote:
>> In zonefs the file name in one of the two directories corresponds to the
>> zone number.
>>
>> Here Alexey reported a possible integer overflow in zonefs_fname_to_fno(),
>> where the parsing of the zone number from the file name can overflow the
>> 'long' data type.
>>
>> Add a check for integer overflows and if the fno 'long' did overflow
>> return -ENOENT.
>>
>> Reported-by: Alexey Dobriyan <adobriyan@gmail.com>
>> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> This needs a fixes tag I think.

That would then be:

Fixes: d207794ababe ("zonefs: Dynamically create file inodes when needed")

Can you add it when applying or should I resend?

