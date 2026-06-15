Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A35E3F20F3
	for <linux-fsdevel@vger.kernel.org>; Mon, 15 Jun 2026 14:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781533187; cv=fail; b=RCzxFvGNnVnMo2xIsLOFR4Dh2RpVYJi5ZRC+VTKEUvzwzDfl3K59aF8d92yAPCS7exWc+RNE4fM1A1hJvKRhFfh8aU+SlQsrkar/wx+3Y6o0B5zlJPKZpB0KuPJdstp4hvAtHsnBxAMnPa3gkXCwWRb8cza8kq4at/eulLay5Bk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781533187; c=relaxed/simple;
	bh=czXaTDlO5uNka1aABAKqILS9sWoSsbUhz326Pwk3w7o=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=pDEQEE6KZOUNM3qTf5zakCy7bnJRvgEo0TPqXReaKR3xRHFT4cyvOWGpF8GtqYhGIVjlkl4tSNJU1E5YlBlrjVB5UJBZxSBqO2L04zsosu6lURevm/sKgSPREjS7ssUTSyooo40OmmD4rZxLyJICAE03dHzq3C5LVusEpfCyRxY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SEFmX3Xk; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SEFmX3Xk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781533185; x=1813069185;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=czXaTDlO5uNka1aABAKqILS9sWoSsbUhz326Pwk3w7o=;
  b=SEFmX3XktEVtbFdlcrtj2wsHG7zc8w9AxZO1paswzU9Qw/2TFi3c7LkJ
   5OYSGDrKs4TA3rb78GQm1r9eEWkZbrR28OvdWa4IzeV+bUc3w/MF1ylk6
   cYCceFCyYAfJ7HauiGcEGOyMzhQ6/POfp1G050CNLEIWx1RGw0z+gH2aM
   5L0dOtTwnVkds3wCjg6ErSnFYQ6kI6T3HJWKcxydzuofdG4bL+aCGFdn7
   6PI/8iV0xddJNYc5qy7t8NBwE6hQuv+T5K58zLx0ZqJ5c6kBzuAa1L28w
   M5TBWFFB4fPwqBuike83OtRIpGJre3jngOyPQ5NG8e3Ruxzr8MS6zpJfO
   w==;
X-CSE-ConnectionGUID: 69K8u5ClQOSB0uas3Qh7Fw==
X-CSE-MsgGUID: 3GVShj6wR+2ypNjMZH0GYw==
X-IronPort-AV: E=McAfee;i="6800,10657,11818"; a="85907239"
X-IronPort-AV: E=Sophos;i="6.24,206,1774335600"; 
   d="scan'208";a="85907239"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2026 07:19:44 -0700
X-CSE-ConnectionGUID: B0W2VI20Sp6meFm4u06TBw==
X-CSE-MsgGUID: FK7WQDbxTZe9CzfDCiKBUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,206,1774335600"; 
   d="scan'208";a="285595373"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2026 07:19:45 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 15 Jun 2026 07:19:44 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 15 Jun 2026 07:19:44 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.65) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 15 Jun 2026 07:19:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=er74l1/QzrZ3HPOHlEWezBkVKBIy1Hwx2d64xV5IcOGzsvsDLKghlsFl9SvV0U9SEkt+XSPNLQipXlp6d+SYTexKhzAskvKhevkLDBZxOtocE0S8hp1C8zMZpF3cnhBSLxAzj5jWnLm3DnKQWlaCFQrOukDOGsxHA8vj79jXoe2PXPlFWo3racsEk95NA7W3ZjYm+7snCMjgdWQ1ITM8gMs6XwhGNelIpabvbJJZzA+/RR2e+PuUFIKzz0zPySxkk2AFHUQDqtbjfNouS1BiTLW9sRKygyOocq0djdfoMLEIjoZB1FtNjmOlwxQN6iuO7aPesYBHBQQru7Mc1cvgEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gzYIWC4YRRt3FJpMPCk7IB1Os3qsw3MHjLjIOH95zK0=;
 b=kT/C+/Yu/UuNk1RSg/hoSVYJP16W3U5cyJMZs5U5CMhJN5lCTLdjesKOEh3QhQBdDXDTyqNjExt1qZ9E7FTOMHbxe9gOjSTIclWPUnyWirKckjpHqiZ5Mrb8VXrt9z3/XI3E8dXd8s0rLY1NXP02WtFJNeJ0VZCLbnHXvZS2RVhNLaom+h8Y86kcr/7e3Mgu033xeAiBf/bsgl/WRsbwiulhzxfiAL2wsmGW6QGvxWau/kEvP5tTztoOYOz85r4pZY4/Kh7B3FBBz/PPZv1yxVT1i7saXthwz8Y7q5LHCMSqrkFx5zfuN83Hqrz6kaofd5rVC4MQCsH94Tbp1AjwqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB5832.namprd11.prod.outlook.com (2603:10b6:510:141::7)
 by SJ0PR11MB5792.namprd11.prod.outlook.com (2603:10b6:a03:425::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Mon, 15 Jun
 2026 14:19:40 +0000
Received: from PH0PR11MB5832.namprd11.prod.outlook.com
 ([fe80::106e:78dd:4c96:d707]) by PH0PR11MB5832.namprd11.prod.outlook.com
 ([fe80::106e:78dd:4c96:d707%5]) with mapi id 15.21.0113.015; Mon, 15 Jun 2026
 14:19:40 +0000
Date: Mon, 15 Jun 2026 22:19:33 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Hannes Reinecke <hare@suse.de>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
	<linux-fsdevel@vger.kernel.org>, <oliver.sang@intel.com>
Subject: [hare-scsi-devel:configfs-ns.v5] c30cbbf5a2:
 EIP:configfs_link_subsystems
Message-ID: <202606152237.4fa64355-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
User-Agent: s-nail v14.9.25
X-ClientProxiedBy: TPYP295CA0031.TWNP295.PROD.OUTLOOK.COM (2603:1096:7d0:7::9)
 To PH0PR11MB5832.namprd11.prod.outlook.com (2603:10b6:510:141::7)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB5832:EE_|SJ0PR11MB5792:EE_
X-MS-Office365-Filtering-Correlation-Id: d1b3a56a-a952-43ca-4940-08decae92309
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|56012099006|3023799007|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: +GJQK5pv2SwbvaY6nWXXmmKMtKQYjT1dXJNis9Rq6Q853A/mohh40T/SzXvBGWJNFjRHLNc19tQjLO8fkMD0EeB5XM3X2CUHKGNhPumZO5KFxt4QqNYNYeXnUnJ6FtpMn6Hllv7D16oOHmyY5/B+MnxTIupVhFGk2mHzA+aD5VEjNcZZZeyu+SfTYZqrkoL4f8u9RZBaDKXL4bRL5uchjvBZUw/ETXIF+czk0jCt5oqlmbeoRMnsnXXB/arekwKQ+pL+DwhCpE7LoZfb8X3b+FWJnzwX2eiYE7WxgFK5Ao8XVsVftu/YL14kL4bRE0rjVQygje9YcCvqq1rER/ZW4Hvix1uzc6xfk3Tc2tn2f3E+Q1Hu/pLGKbwBuiDaOoEjaOBzl28xioKxyLKM0nfJg97g77lNZqbtJUHQ+MP056uumV6CZ/Jd9g1lwe3D08sHLczJ3UKMwm4002IWLnCiZRR7KvyG5GLiO2OcOODDWhRfarTTZXJ+5pciMcTAXSZoEfNUMtP19U/JH59DPv7RyagjHEQkkzWdfEKghMaKKzi10u1K0GYT8BS08Ypy7oBmpr4fyBn6uwECuhobHYdPaZd+/P0qu8PD5kG9ng+FwULShkaGNWi/w0JrnuvzdwbWbNq4zLben40rTu4UGRUI/yDg+9k8BK3c3zqRG/9QL+3WDPBJ9DqlWqQHWKZz5Wny
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5832.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(56012099006)(3023799007)(11063799006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ubUnA3y4YteuBiDQcXF4kSppm+se27KeP3ucO8frHrDfRGVRvJ2PiSklLIAj?=
 =?us-ascii?Q?zCVlKjfFDA3hqGVoYPGES47XdLA4RQZq6IlFDuoi65fMqhE0FUA+osyuavm9?=
 =?us-ascii?Q?AYqGk7nbuprqU22uX8x/IRIIIMDm65p4aJAXDxOWJjvNTRsn0QQQ23t5GRds?=
 =?us-ascii?Q?H+2tgmIyr+LL/B0LR+4SzTfGI3j0KN6iF/w7G9OFw1vfh1LnzepbPmC/e4ZQ?=
 =?us-ascii?Q?5XsBsThd4jBuuv0K2AO5fw0J6FxbULGHjq4bbMVArBRZFocKiohbF+LNUDTm?=
 =?us-ascii?Q?CpOTWLoOak3IGKYyDPfcxC+bIsz8ssj5+tX3ZLY2mQqUHHxD2+Hk1McefuD4?=
 =?us-ascii?Q?eexK0jPVFHaXFzT8E5dc3S5jxaW5BPcDa0zd7f/+hPUsKLLBVfJsOyn6mGDU?=
 =?us-ascii?Q?+MSeyaz3pPtbDyf2OJECYyLKNu1pIqhfP1Z2sllSWPwE3W6IxO02C//LHMhr?=
 =?us-ascii?Q?+TLtOa72cjUiqBHRAW/zlY1R/nxqFhdcFGL7EdGkPfqqXOfjuwrG/KaC7Qps?=
 =?us-ascii?Q?WGOg2PWlss/cM64zY5urhT4YWUR5noBZ6U88rwkd99Su87HHQumIMsSEZy7h?=
 =?us-ascii?Q?56QMnIQqE/o099rpWIX/S4G+2iWDYjfvQGAfKi0UCsW0rEfpBCMELle8Pf2G?=
 =?us-ascii?Q?6yV4byVkvnOmST44r/R75sJK7d4E3GS/96p9Jv72PxZI5TVeUYLulIlFKxjE?=
 =?us-ascii?Q?ds8Jn3NDc/gM3bUX4BS2136GJZ9XyxtZ6S1jfLf8GS7zYC+dBvzlM2WxDmYh?=
 =?us-ascii?Q?/Q+OHKM4/8ZsmYNYme3BKttt4vGXfRbdNmM6rulVBhE9P0zkIYJ6A8sXSBsn?=
 =?us-ascii?Q?223FfsuzQ8leV1G+8ajefKuqVRoKqiK0vfdeWBTowz5HF9RSLs8LNS1z4npa?=
 =?us-ascii?Q?A8gg+B0bUTIZjnMKuK+iB+5qZOyiB9FOa6Loa1XhlELsPhr1OKLhULbzEtbJ?=
 =?us-ascii?Q?XpDKeg2B/JeTG/cQ4R/aMnioEbUthmLFk2WW3WdSvK3WuN6cf+X+ikm3kVek?=
 =?us-ascii?Q?3ye/8YeMfFXAVqaXiyrUC2BwZZCuHpJlsYtQn/0GA3kfvLK5E6qiBQyzC4LL?=
 =?us-ascii?Q?4NMmWO6GXzSBdTRaqM/zztAB6bjjV0I+V6nxhyxFqQARa3aN2WjEwgbWDD/H?=
 =?us-ascii?Q?8X1fxzDk831Sx8ppGg8wKHzc7zOtANBDp2jQPQaYZYQIH6VFXgrGsqV0uSpN?=
 =?us-ascii?Q?EW9cdp6VmncOxUjP2HEXajV4lN5xO3OkT4SeYQ/OLd0GwXecrPc/lmnZSXUq?=
 =?us-ascii?Q?AJwk3r/f5bf1z8xKVyaS5XZ9zmUzpA9e0okjmpmk8HODcx0lD1rHZ/xXHEfi?=
 =?us-ascii?Q?Whmun5UUD751B0ftjKjrZ5ouOtEnntVLF5feef1LsfSBKHdksAbb5K+8//P0?=
 =?us-ascii?Q?zzF6jg9nkObfyEVwcHn5m4kvWx8A9v8f/sGIOIdkoWx26+syNTS4oBtU9oJU?=
 =?us-ascii?Q?VzVSS9JeRPlMF8MkTwSpVp8lU3Yda4MLXhD5JxpowlwbdCk0fhsFKuDuRJQy?=
 =?us-ascii?Q?pxy+86nXiBnnIEFfwghbIJUCNy5rvUAwfNEljbvsWdiTnxGNVfCaYy4QpfDt?=
 =?us-ascii?Q?QBNn5KKQBBvrz54V0TpHb0Th3Qb+m157XLAgF8CT4fNKbY3VBYoAX6CNNkwR?=
 =?us-ascii?Q?SH3CdVwjcjL/A+QsZEE33g1rGtWAi51wBjrmlhHF42WcP8b9YnjdRAzZ8Vp4?=
 =?us-ascii?Q?+qwdtf0Avg3GkTXTvc6bBHEm4pnI/McX5doUSQuI/R8Aic2MyIZFYik0nws3?=
 =?us-ascii?Q?na5pEXRhzw=3D=3D?=
X-Exchange-RoutingPolicyChecked: O49xMraQJMNF2vF8GkugQEH6ppRCwTNYK0iRkLMhPBQtHqxP+uVt+1E5Rqo1xpgRLwFWIx65elXH/9aQQR8dnLx8MMuA1/2zv077dF3/jjBKn9JmnY24B9gNJhRaHieYPDdZLZb5ZA/KS+ubXwMiqCJfPOv9ou6a1l/GyhLKQOb3z9EXo63+BCzRrQ/tZRPvr9vvZAc/f0yPxk6y27tyJe2wNNutuhFLZOVgV0GG4r8Hi98N/o/cXQU4zwtcg7ROePkuk6Ae7yzqDFxT/m62YUrxYGOsWo0QGvybQpbymXn1qQGUMBa/7+tuoHOI3GuUBefWFTwiVH2JuDUoyyocyg==
X-MS-Exchange-CrossTenant-Network-Message-Id: d1b3a56a-a952-43ca-4940-08decae92309
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5832.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2026 14:19:40.2074
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QdomIR0paFpp9DzJRAyGMNKFERdw22oEoku/hegh3LfEPzW7FRpRMDM8TuQZc6LQ2Sc5KDLiaL8InS5c7D0Tag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5792
X-OriginatorOrg: intel.com




Hello,

kernel test robot noticed "EIP:configfs_link_subsystems" on:

commit: c30cbbf5a225651bcec95051409f08b2be078aa8 ("Reshuffle pin_fs and drop global mutex")
https://git.kernel.org/cgit/linux/kernel/git/hare/scsi-devel.git configfs-ns.v5

in testcase: boot

config: i386-randconfig-013-20260614
compiler: gcc-14
test machine: qemu-system-i386 -enable-kvm -cpu SandyBridge -smp 2 -m 4G

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202606152237.4fa64355-lkp@intel.com



[    6.264454][    T1] ------------[ cut here ]------------
[    6.266633][    T1] WARNING: fs/configfs/dir.c:1937 at configfs_link_subsystems+0x2c0/0x300, CPU#0: swapper/0/1
[    6.271620][    T1] Modules linked in: aesni_intel
[    6.273169][    T1] CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Tainted: G                T   7.1.0-rc2-00056-gc30cbbf5a225 #1 PREEMPT(full)
[    6.275841][    T1] Tainted: [T]=RANDSTRUCT
[    6.276725][    T1] EIP: configfs_link_subsystems (configfs/dir.c:1978)
[    6.290683][    T1] Code: 76 00 0f 0b 6a 01 31 c9 ba 01 00 00 00 b8 68 7e da 82 e8 93 ad d9 ff 59 8d 65 f4 5b 5e 5f 5d 31 c0 31 d2 31 c9 c3 8d 74 26 00 <0f> 0b 6a 01 31 c9 ba 01 00 00 00 b8 38 7e da 82 e8 6b ad d9 ff 5b
All code
========
   0:	76 00                	jbe    0x2
   2:	0f 0b                	ud2
   4:	6a 01                	push   $0x1
   6:	31 c9                	xor    %ecx,%ecx
   8:	ba 01 00 00 00       	mov    $0x1,%edx
   d:	b8 68 7e da 82       	mov    $0x82da7e68,%eax
  12:	e8 93 ad d9 ff       	call   0xffffffffffd9adaa
  17:	59                   	pop    %rcx
  18:	8d 65 f4             	lea    -0xc(%rbp),%esp
  1b:	5b                   	pop    %rbx
  1c:	5e                   	pop    %rsi
  1d:	5f                   	pop    %rdi
  1e:	5d                   	pop    %rbp
  1f:	31 c0                	xor    %eax,%eax
  21:	31 d2                	xor    %edx,%edx
  23:	31 c9                	xor    %ecx,%ecx
  25:	c3                   	ret
  26:	8d 74 26 00          	lea    0x0(%rsi,%riz,1),%esi
  2a:*	0f 0b                	ud2		<-- trapping instruction
  2c:	6a 01                	push   $0x1
  2e:	31 c9                	xor    %ecx,%ecx
  30:	ba 01 00 00 00       	mov    $0x1,%edx
  35:	b8 38 7e da 82       	mov    $0x82da7e38,%eax
  3a:	e8 6b ad d9 ff       	call   0xffffffffffd9adaa
  3f:	5b                   	pop    %rbx

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2
   2:	6a 01                	push   $0x1
   4:	31 c9                	xor    %ecx,%ecx
   6:	ba 01 00 00 00       	mov    $0x1,%edx
   b:	b8 38 7e da 82       	mov    $0x82da7e38,%eax
  10:	e8 6b ad d9 ff       	call   0xffffffffffd9ad80
  15:	5b                   	pop    %rbx
[    6.296593][    T1] EAX: 00000001 EBX: 00000000 ECX: 00000000 EDX: 00000000
[    6.298852][    T1] ESI: 80113000 EDI: 80113000 EBP: 80337df4 ESP: 80337dc8
[    6.301048][    T1] DS: 007b ES: 007b FS: 0000 GS: 0000 SS: 0068 EFLAGS: 00010246
[    6.315892][    T1] CR0: 80050033 CR2: 77f65cd4 CR3: 02f68000 CR4: 00040690
[    6.318169][    T1] Call Trace:
[    6.319175][    T1]  ? d_instantiate (linux/spinlock.h:390 dcache.c:2081)
[    6.320578][    T1]  configfs_fill_super (configfs/mount.c:156)
[    6.322193][    T1]  ? configfs_unlink.cold (linux/list.h:132 linux/list.h:223 linux/list.h:295 configfs/symlink.c:230)
[    6.323768][    T1]  vfs_get_super (super.c:1327)
[    6.325079][    T1]  get_tree_keyed (super.c:1364)
[    6.339136][    T1]  configfs_get_tree (configfs/mount.c:170)
[    6.340538][    T1]  vfs_get_tree (super.c:1754)
[    6.341914][    T1]  ? vfs_parse_monolithic_sep (linux/fs_context.h:142 (discriminator 2))
[    6.343687][    T1]  fc_mount (namespace.c:1193)
[    6.344871][    T1]  vfs_kern_mount (namespace.c:1231)
[    6.346307][    T1]  simple_pin_fs (libfs.c:1102)
[    6.347661][    T1]  configfs_pin_fs (configfs/mount.c:239)
[    6.349018][    T1]  configfs_register_subsystem (configfs/dir.c:1900)
[    6.350779][    T1]  gpio_sim_init (gpio/gpio-sim.c:1618)
[    6.352080][    T1]  do_one_initcall (main.c:1392)
[    6.353467][    T1]  ? rc5t583_gpio_init (gpio-rc5t583.c:?)
[    6.354986][    T1]  ? parse_args (params.c:153 params.c:186)
[    6.356314][    T1]  do_initcalls (main.c:1454 (discriminator 1) main.c:1470 (discriminator 1))
[    6.357647][    T1]  kernel_init_freeable (main.c:1490 main.c:1703)
[    6.359228][    T1]  ? rest_init (main.c:762)
[    6.360525][    T1]  kernel_init (main.c:1593)
[    6.361824][    T1]  ret_from_fork (x86/kernel/process.c:158)
[    6.363252][    T1]  ? rest_init (main.c:762)
[    6.364527][    T1]  ret_from_fork_asm (x86/entry/entry_32.S:736)
[    6.365921][    T1]  entry_INT80_32 (x86/entry/entry_32.S:940)
[    6.367299][    T1] irq event stamp: 67993
[    6.368533][    T1] hardirqs last  enabled at (68005): __up_console_sem (printk/printk.c:347 (discriminator 1))
[    6.371225][    T1] hardirqs last disabled at (68018): __up_console_sem (printk/printk.c:345 (discriminator 1))
[    6.373845][    T1] softirqs last  enabled at (67734): handle_softirqs (softirq.c:468 softirq.c:650)
[    6.376494][    T1] softirqs last disabled at (67725): __do_softirq (softirq.c:656)
[    6.379044][    T1] ---[ end trace 0000000000000000 ]---
[    6.380681][    T1] configfs: configfs_fs_context_free: ns 0
[    6.382718][    T1] configfs: configfs_get_super_info: use ns 0
[    6.384538][    T1] gpio_virtuser: Failed to create the debugfs tree: -1
[    6.386631][    T1] configfs: configfs_get_super_info: use ns 0
[    6.388488][    T1]
[    6.389150][    T1] =====================================


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20260615/202606152237.4fa64355-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

