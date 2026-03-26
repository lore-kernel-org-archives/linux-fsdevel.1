Received: from outbound-ip191a.ess.barracuda.com (outbound-ip191a.ess.barracuda.com [209.222.82.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 566793385BC
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Mar 2026 19:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774553582; cv=fail; b=XK3GvAy6yhvVIMotUcI1RpfJxiLLYrqFS1Fu4arRFWrc0EC7B529GPerOQSiSx9xgHfjOfviFeb0F324TbBbbQNpNQJYUYHaj+mr+3TH3J4CKdAnQjXItG67DvDUiYwlOTsrwRhTfMfhimeFRGYGwscKdoRar9pkSe8GT88Lg18=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774553582; c=relaxed/simple;
	bh=AidxpzSsaoRBnUIrLFmweET2z5bIArmAUqSpaQuY3JA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=H/Rvg4zcV834/3ROJVUiHBt3ZkVvpy2DWYNtR5cujYj3OxdTcyRGRjX6dMis8FvK+1y61sOBz4E1Ehnh2FE8exvdEg+fVvQFBeVJLqT88u0GtBEj0XPVErwq/R9AYX5hBRrV1ivjS+nynefqQC4hks7b5YXPkXXrkmd9G3CF+40=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b=V/BzBtYY; arc=fail smtp.client-ip=209.222.82.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b="V/BzBtYY"
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11022129.outbound.protection.outlook.com [40.107.200.129]) by mx-outbound40-126.us-east-2c.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Thu, 26 Mar 2026 19:32:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZMQshkpJmda+N34Qnb/kE3I9QlmXr2iPqDgcOGI6+X/JB/nFB3+jIqWyecTZmXVELIBujrc7U6rZrrvTPvSRJUJDQPPj+MS6PerVLEW2dpzIj5y92h+6WHxDbbn/OFlJiGrOqWcorl3gf0cNVelX7INMYwFWs7+1tAXPzFVrgxTln/bPNqHwa1ryvSJDXem0HJXTxGFzwvLqiYjp4lHwGGbq8nW+OO4kOdMBKJeBhJe3stFGBznM3dRQY4xCyo7EfV3mlMxRoewM8hK/Vrsq8Vh1pmL/rJyw9a/Ul4MEgPq0CYEm8A86qIW0T6dyq3Za8kPqTT90YuBxp2fD8KgdWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fAwVJgFKOFRc6NfjW3BzxSAIVIQCvEDwZUwxBPLusk4=;
 b=ShrVXB6py8hZClBN9R41fqSggJwH8wqMZRSp2+sd0RyM3xmo/b0Hc5hFPvXxfS70DhC7NmyvOVqxN+gOSz2+lChhncGlQj9gnCljBv2C2+Alhh86y6Q1XWrPEO5s9CK2yd1JoiCDhOdgwc7lXeElrDBecfZFHzHN7Uzd3wfW8MIv7SalhgSh4+2Z2BhQfa1vFTeWxhmmxt5XjZVU2wudJ4IdnJXAFWPpR3ROUM0EK2XKCricBVX5xf/7bOVGFFzzfw8yU+jspdObHUq+p+PM8kxYxVEzSBFHCgJHFi1TSOXo3kEJIC09qav3eQj2K6lUQq6UAf0lRTD4wtlWeriRsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ddn.com; dmarc=pass action=none header.from=ddn.com; dkim=pass
 header.d=ddn.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fAwVJgFKOFRc6NfjW3BzxSAIVIQCvEDwZUwxBPLusk4=;
 b=V/BzBtYYJYOOdkJUgpvNlGt5a56Bs/jS1vNMRP/NS2/Hhb/KH5ChgoVuV6T+TSiACOurk7N1MBhq+s5unAU7Xm6HVHMnuZiNt9BxGgtq1MlF8raMa+O02j9UrOcZyzYdEg5aaKgIHwmZWqHK9OAmR5mZS6rPD/EySgw1HwSFKRo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ddn.com;
Received: from MN2PR19MB3872.namprd19.prod.outlook.com (2603:10b6:208:1e8::8)
 by LV5PR19MB9060.namprd19.prod.outlook.com (2603:10b6:408:308::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.22; Thu, 26 Mar
 2026 19:32:27 +0000
Received: from MN2PR19MB3872.namprd19.prod.outlook.com
 ([fe80::5787:9b5e:45ce:396b]) by MN2PR19MB3872.namprd19.prod.outlook.com
 ([fe80::5787:9b5e:45ce:396b%6]) with mapi id 15.20.9723.018; Thu, 26 Mar 2026
 19:32:27 +0000
Message-ID: <4fd3c5e8-89e0-4356-ab50-4aa7544a142f@ddn.com>
Date: Thu, 26 Mar 2026 20:32:23 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/19] fuse mount: Support synchronous FUSE_INIT
 (privileged daemon)
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Bernd Schubert <bernd@bsbernd.com>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 Miklos Szeredi <miklos@szeredi.hu>, Joanne Koong <joannelkoong@gmail.com>,
 Kevin Chen <kchen@ddn.com>
References: <20260323-fuse-init-before-mount-v1-0-a52d3040af69@bsbernd.com>
 <20260323-fuse-init-before-mount-v1-12-a52d3040af69@bsbernd.com>
 <20260324000350.GM6202@frogsfrogsfrogs>
 <e0d7b5ee-ffef-45a4-8c39-84cd79342bae@ddn.com>
 <20260324225012.GY6202@frogsfrogsfrogs>
From: Bernd Schubert <bschubert@ddn.com>
Content-Language: en-US, de-DE, fr
In-Reply-To: <20260324225012.GY6202@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR3P192CA0024.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:102:56::29) To MN2PR19MB3872.namprd19.prod.outlook.com
 (2603:10b6:208:1e8::8)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR19MB3872:EE_|LV5PR19MB9060:EE_
X-MS-Office365-Filtering-Correlation-Id: 73efb6e0-5477-4580-f03f-08de8b6e6991
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|19092799006|1800799024|10070799003|366016|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Z5R6ANOhiWc/5HMmKsDCHQ7o6LcnzXXRopJDQ14qJxC1DbFDRn/CrH2p96e53VssoaKc9ip44KdNfTJTeCRrkfRUr4/mTga/v9TqD3eln25kZizzhtD8jdtRJpebQ22vdFMJx8/cC/cDeEFo/uCozN+aSf7SqARUPLUmGc9kokdLXjOCQAo/AgiRNBINo73T9pJ3UzYCEP07myEHLb5d1PGpRMRcpEQx+082vtoVZbxK6RNWW8AtenPS6x3bWhwAe+xPxcWKkZXZftraM5z63CpNEnco/MZ3W6Yg5T3qvG0SdgxNZ0SjejvFMdTzx3Hn4WMLV7NV0VdcbYTY93XZOl+urDWTszXVC4YnKHn2t6xdMX2bI6vY9bvqykX38AeMq8YkXQPx53BNunaFMjRaoFJ6TiH9GAEDAGv74rVCr01lc6CzwIXqQpN34RsJB4JUYb3myCbP85NSkD6oHIyQRRXsJJ37JArWSPvkjUxAl9K1fM9Afb4jHGquxm3Vb+kkh1QRWIy1DJp9z3+uTDCSyiIHBv/bKGVZgYVd1g4xizPIWoAsB1NExWG85blAYfoyv1gI6Jxbba4UBKDlCOP7ou6M/MA5OO1q/Sg0HDMTXelnWBBLr9a7+fedhV09roNlONbbauJReSV9DzUpC7fIsa+Yw7pB/pOoGpcdHNuHGxdWCZNvKNPXJh1J1mwWUqQq+z9t7hrvXVjBjQJ7RWcYWc7re357seSpVOspBRVu5rg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR19MB3872.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(19092799006)(1800799024)(10070799003)(366016)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZG5xalFibG5GYmU5N2J5WjJBM3pOcFQvUXZlVXpxUTZzdGNaT2ZqVkp0WWJR?=
 =?utf-8?B?T1B0eUVNb0NYYlIyZzJ5aFdCTFpDS2VFU3lFelpOcWl1QmxYR2VhZTRYVmxh?=
 =?utf-8?B?UE1ua3B1WlZ4OUtGbnllN0x3MmxUNFRXaUwvWWhXa3JGN3NYcXcvOWhwbmVp?=
 =?utf-8?B?Sm92RmdOYWU0S0J6R0FlOUtRT1MrQjNCSU41ZDhBRkZJTnBNeW03SlF3OW9p?=
 =?utf-8?B?dUsrNlhqSlhibVU2eC9WYkRaNU0rY1R1L3paaXAyWjM2MlljUUx5R0VQL2RT?=
 =?utf-8?B?bEtlQnJyWi9sUWVKc0h4c1ppWGtEb3F0eHFBbzZwRnh3U1VyQzBEQlp6Rng5?=
 =?utf-8?B?UHJ3Z2RxMjdudjd2WmtvMElpVGZ2VEs4RkFpVjRQUVVYSDVXV3NoQ1R5RnpT?=
 =?utf-8?B?OFVIK2t3NDVXS1Z0Y0pBNkVNdnh0dG16OHVzTXIyTVVoL3VSMFR2Znhrak9n?=
 =?utf-8?B?bHNNQzZWb2hjTVhJTGV2WUlxR3ZjVkJORzVDQzBqVkxxZGN0NVNaMkpOTjNZ?=
 =?utf-8?B?cUwyb0NlSDExR0ZRcm5sNnFZakh5bENETnZwa2VJNk8zSXFkZ2Y3Y2Z0RGJt?=
 =?utf-8?B?R3U0bnhYNXJYeTRYalJDbG5WRWtxQWhEaWxmdG5jT0ZCTzJZb2V2NC92a2cy?=
 =?utf-8?B?MTYzMDl0SjYxTi9LYnMzdkJidnJCTmx6bmlLZStxZ1R6TXVQdkRtMjhWdmJy?=
 =?utf-8?B?Qit0NmF1c2orcm5MQ0owN01kMXZKOEE0RkRxTmllTUZZMS9OM0U5aURFZjdM?=
 =?utf-8?B?cWZYRnJ4cTI1c3ZsQjRPV080TnJvVHdqenFJeVJTNFB6Wkwwd1RxOUdFWGRq?=
 =?utf-8?B?aDFCVGhyWGpJeXZMKys4ZmNxUUU1L0NPR3lJZ3VzanErUjBYNDEvU28xNTEw?=
 =?utf-8?B?NVBpZXhiQ0lsTTlaM2ltU1h4eVdlT291YURRUEpjdzNLY3hkK2Z0MHE0MGpZ?=
 =?utf-8?B?dnpsNllva05zOGo2VGdabWp4eEV4YjlGcFo5aDVreWdPS0RaUmdDdDR2WXp6?=
 =?utf-8?B?UGMyZXJ5Y2N5V0dDSnJrZVRoU3dqOGh4V2hhejB5SFJYdE5JZnZKWkhEeTdv?=
 =?utf-8?B?MHpzSndGOUkwRlJrS0c0Vll6SFFWbldtd2g5RHFyeWNFejlrdnZzL3UxWmsw?=
 =?utf-8?B?RDE1ajFXOHU3ZjVpMi9kSGI3a0EyY0pRbGdCS0pCSlp4cE84elBEWHBHTWV2?=
 =?utf-8?B?TVFGQ1VKTkF6elA5M3hGMStVNEY2OGkrWHBuWG5vMEM3andielBzUW9HK05F?=
 =?utf-8?B?OVJBTWlUMm9PU1FsekZjNTZxa2NCL0pXaTVkN2JFYkgvbThkSDExRzFGb3VF?=
 =?utf-8?B?T0xmaHpoazA3Wi9RV3orSmFGTlRRa28xZTRoQnJLZTlrdkQxV1dHeitOTzZZ?=
 =?utf-8?B?SnBVMHd4OWw4ZXo4VzFiVnNrMmY4cUpiTXA4R3hrd09sSjUzazFsMld5OWll?=
 =?utf-8?B?aXh0bTNjMkpRZ1pUc0VyS2w0RXhyeGlzWnp0c014bWk2OVFSWGN1Tm1DY1pl?=
 =?utf-8?B?bmUydmVqbWRmQTNOUUtoMTFtaU9Qd1BLaTE1MEJsUHIrNEFIWnd2R0dqZGgr?=
 =?utf-8?B?M1BZR1pCK08zOXdMa1V0K0o0NU9xRzQ0eUV4U0syYUFMNFdUaWJmV25IQXFt?=
 =?utf-8?B?UzFXNG1PSVBZcmlqRDhXZVdTV080TnlKbDhBd0lOYmRCc2UzMzcvSFZFNlJS?=
 =?utf-8?B?UndsN3VDNXRSZGgwZjRHbG5kb2FwSmF3ZllDQ09YUFEzNlc4bzBMQXJQZG45?=
 =?utf-8?B?alRGTjFzQXZmSDRlQlpwK3IxNHpNaEswRGNRNk1tNjZXcE9teFJlZWwrUVJv?=
 =?utf-8?B?VnpibXJuYSt0OFZSREE0eGhMbWlQUERKT0dxWGFFclZCMEdKM0NSWUhjWTJK?=
 =?utf-8?B?VmtLVWhpY25iK0hhSmlpZ1RMeWxqRktyS0VkWEJzS2xoNVhRRjhQc0ovZERr?=
 =?utf-8?B?S3ZZRmVjejdhdlhJVkVZUDkzTFVvc0hvNUhQVzZDcFJBWGw4TFI0RUNxdmtK?=
 =?utf-8?B?Y3IyTWhYSGt1dDVZcUhFY051bTFYTU5yWUpYNWJxSzV1bVprQUVNK2hvNEpQ?=
 =?utf-8?B?eU1WVnBkKzdBMGhnUjNBQVdRWTl6bVpxL2l4SmZCZkFhUWcxVktlZU96RjI1?=
 =?utf-8?B?YXBxYWtmUFJyMTFHSXNJTzd6ekZqZGlaNlVuczJFUnhsRUNkYTVpdm9PUGs0?=
 =?utf-8?B?N0hqSFJCbUphTncrL1lsU1ZidzBjc3BTQXkrcm5NdXgwRTE4aDV2TGFSazNX?=
 =?utf-8?B?VUdmL3VscmQvcWlleEd0aG41bG94WWlTUWxIMlFIT1JuUE4yejBCV0FtQmlV?=
 =?utf-8?B?KzY0dklQSnhMZFJwSld0cThtRmlNcldYMXBpclpLelMxOTBnOHFvQlEyZ3cx?=
 =?utf-8?Q?JSHJRqXhs+lZBnEKnPZQXTMd6BPSiyqJlttNnDP4tUMQf?=
X-MS-Exchange-AntiSpam-MessageData-1: iH4uQiaisnGXCw==
X-Exchange-RoutingPolicyChecked:
	kGEuzPAAK20iodLadplzhUeZYleWMebDWjk6jEtusobuFm5eMbyG3wTsqGU1WyEUwo7uJ2QQeuejKiDaTcmodhpdQ7JnmPWSibPLCQEK9knA4dOusbtKu9c3EQcSc0vJktKnMmRwUaMAAWpPp1NoEwtFiXiFq3qVUMHEVt8Ue4sflsLfT6m803LK4/Z1GWmPDv+Rm5qizxihcTqHIkKT4PbPbg7bkw+i3T8u5YWMn8J0/KKy6LNM2y8db4oDXCu5jVQpRVGGWDk+cINS60xD+ywi46omhEV6DJYgaeDcYMqTg2mqRqR0llQLU+I52zlxYQdj7k15znBaIOHNw/3GoQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	zCyzQcYxfVM7TT73OF59nnyqxwOpike+7pGlg9t4CIqZrtMBBTr1xI1+STuksFEKkHOtUYA2aj96CT2PHLuivI2hgb6V+XBHxe4T7DErT3a8obN80DfRQWXAuSepnXzojqRZ2SaMJsfuzFLk632Zy1qc6V7HeCjpDdjThpOxS39i6sgsCWXfEOpUubUUzyER39wZm+ItAI0W6nv/jTenvKa/RgU+eSfYgYV4yVA/AIsfspq+fuWFFE5DyhhE1t9tOCq+esYqdTG8twuLXVTJtVGq66MkDSoKqoYeFGi9Ozo2w+hSIS7m4fmimjLDDlNd+khnw8A1wTMaxH61DyXObnmTpbqtL96FB9Dv61q+HpYY4h2fJw8GCKpkFs0B1fjk7nUH0C9ygVsHo/Sjxi21LT+1nZoExwbKP5BIhtVRxsmX4g9DcmOTx1C35g/Zgf1upXUSaraGBYeFF/gWaRMfwue4rKpcFG9ZF1loc+rzxqoA+t+tqCuVbJ4cBhHhMtLVhEUce7Nyco1eW/ILJfpfWh9iE/AfoRo7QxCUi9KsT8Pr5ZFOY5konOVAW9+dLAybWOCpFXoK8xD5zVgO9aQ7QEMVbVUTv6/v6wUKsIqow9bfHIVvoi9vCbzbMwzaUWUWsOncRCRpsYDeOdQZJxewGw==
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73efb6e0-5477-4580-f03f-08de8b6e6991
X-MS-Exchange-CrossTenant-AuthSource: MN2PR19MB3872.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 19:32:26.9431
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b6cs5yA5vzmaZvQn73CtxMK8Zq0AiT0+U/sCje3b9ErwmH+zQr3Rb3ywHxCVOR39GvxbzShjLN6Jj7ggWo1pjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV5PR19MB9060
X-BESS-ID: 1774553561-110366-7707-15487-1
X-BESS-VER: 2019.1_20260324.1831
X-BESS-Apparent-Source-IP: 40.107.200.129
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVoZGZhZAVgZQ0DjZwtDYwMIgzT
	LVyCjN0MzcOMnSyDwxJSnZ1NDCwNBMqTYWAFtVNjRBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.272091 [from 
	cloudscan8-31.us-east-2a.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1



On 3/24/26 23:50, Darrick J. Wong wrote:
> On Tue, Mar 24, 2026 at 08:42:36PM +0000, Bernd Schubert wrote:
>> On 3/24/26 01:03, Darrick J. Wong wrote:
>> Next on my list is to look into the fuse-io-uring issues that Kevin also
>> reports with this patch series.
> 
> Heh, well, at least it isn't pthread_cancel anymore :)


So the ugly part here is that one needs to call fuse_daemonize_success()
success twice. Once from ->init() and once after fuse_session_mount().
fuse_daemonize_success() will then check itself if this is sync-init or
async init. Making it conditional in the daemon code itself would be
possible, but it would need two different api calls. ->init() gets
fuse_conn_info and main() or whatever created the session has 'struct
fuse_session'.
Issue here was that I had fuse_daemonize_success() in ->init (sfs_init)
and it signaled the parent that the mount was completed before it was
actually complete with sync init. With io-uring another 300ms delay to
create the rings - enough to make xfstests to fail.
With that change of behavior I'm not even sure anymore if we can make
sync init a default.

Currently have xfstests running (also testing the reduced queue patches
with that) and will sent out new patches one that completes.

Cheers,
Bernd
