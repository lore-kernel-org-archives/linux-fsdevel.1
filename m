Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1585738F643
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Apr 2026 21:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777584644; cv=none; b=ecotQ3480Z+Y9mwmG3fGijXPmO4GezIdxida+pkYXQ+KLJnqNdzLlEChQNIWLpBDj0j04vHjWmvHT5gbMN+16BAShO48rTyvpNHzHVeEAcvEH+cM7pmnEvBSb6+Bx41BSrX/1IAFtB50obRetVmDcIXmiQDxY88bykeebqtoI90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777584644; c=relaxed/simple;
	bh=ZrM6lFX2UCFPg5Kjyem9LHqjHIVlenZXidp39hyYm1w=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=DdBiin22hnoSWkCrhNA2HAgG7KPX7Wf6KV60pRg6MT7IaR2FT51J8GlKOz7T9oq6D8g93BO0AdPstlD2ULjIRgFqKedUf+zK7jDfzXrbaMyb0jVRxh2g049MCyxc6+D/5iKFs0lGBSXR7Zpyz7osdzDG5WRIZqWere+o8411ZhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GwRk+e9C; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=UeV+B5Nq; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GwRk+e9C";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UeV+B5Nq"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63UIcBXt1953348
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Apr 2026 21:30:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	EYg1mHZ78qeUHVxwPW5soi9NfELbaGNPD7XescIFQxE=; b=GwRk+e9C/NctBONv
	CIKu36r0sw9XwAGbMoUqHqk8F3VsXA1Z1IX+hsOk3wgNN/JYTVQvbelDoTs3yzuo
	w8ezTKWH7Cya2BXuC44TAdPlRU8SQmaJcMNXiKYwjOFvyRGDKVQfv7I2qgynfWTY
	r3EApPmP70ekVWgvhzJfgC6bVqHdGWbty3vae3lGMFqfi8tOR8I2JqlQts85BqhM
	8out9exLsmmNUug79lT5bf9BYWkq6CJsA+vrOol8mk12K5q2bS7qoM5EkB+ewhcY
	Vr6TDrt5AHoCmUfADKd0AGe5/EbNQ87zJKvejDFn3FAwN2iZke4/njr9CTXoUrl3
	5870vQ==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dvchk8n3r-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Apr 2026 21:30:42 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-2ee34588671so656240eec.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Apr 2026 14:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777584641; x=1778189441; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EYg1mHZ78qeUHVxwPW5soi9NfELbaGNPD7XescIFQxE=;
        b=UeV+B5NqiCZ/BrFv0CvfbpPzVZQ86lsYxKf4hOOSM5SIVWZtzfUI6P5HqNvtbyG/rB
         agi/3g6jUssY+cpiirMKM+luydqqrlO49iEDyQqXj/ein/yWTUFJz2cG0MGDg4M6NXrJ
         ZVU3MnU8ls1A2DKFZaf52TzwZBci8k9zscVKvViafw5abb0BV4IBECuQShC7nF3f3H9T
         rs6lj02yBk/bSSGL/02yoPaR18wVY7bZXdEAuIwemUDcjs3mFR8P2Ko5RQfrzC+AgZ6/
         GxdPGT30+zPeMYFx4cUhfVvBXcp2kGCEu1JKbKIJIkzEIJ/UWa9vSsZRoytmto3PWAvH
         qvaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777584641; x=1778189441;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EYg1mHZ78qeUHVxwPW5soi9NfELbaGNPD7XescIFQxE=;
        b=GyG1ryakFCYTtZNQNRRwgThpbbxdRpPbpRzTUwByvBlTnfXDnd7NgMdR5i0TuoXrPT
         D2D47OFcxESuFvUO28R0G3K9PNIvwZFVtEX1iB7qyp4Xc1dqfjKCZmAjF9dcb/aqRPqr
         TEdibQC/RNT4ShKF17Ka5FloeF0V1cZxzFoPM+eVtaD14hmLcGPvGoAsbO26098dKBEE
         QaW4ejXIRJy6ek0SwK7WSjRRLsm4oawlwHATEz/tpBoONPcJTxGuOVK1UNduQQ1PYPuA
         pVPLCd/lk4J6SCgW10j0d28tcptDNleVmbz6AbjV5PBPNVS4Td7vLtSU/hcHPcR+Fujd
         NkqQ==
X-Forwarded-Encrypted: i=1; AFNElJ9siDlG4kX51EE/DP2OQ5lY5YBkuxolN7Gf//Yp1xvX8u5X4o7SQfJAvF1jz3z2mBN11iEACQ2wmfdflApP@vger.kernel.org
X-Gm-Message-State: AOJu0YxKHFEM867O+sREcaR2AYuWnfLxPmq65ppAFfr3uxbEf0sCfS1o
	9+co6Wh/EY/wb6fbWYymv/BzBB0RaAPpfnFPZ50TFdKbo0Plj+F4/Ue+KuorcIFYteaY+Un07+T
	c4CXHNCe1fCVg0fAQrOA9tWKSCLVD2GKH6ELgPOicXFhwCP8To9lXFjx4MtlPRUKZRI4e
X-Gm-Gg: AeBDieuuqhfy0VkOrhRZRE/86eI1SYHqS448/AkpSk4B9IsT70wwH9wHb3La8UczfxW
	EQoYaCIAclng+3oEUSWTB/MMthk3obOu7hllDJFyjE04afAHHjsfSIaR/EDcfN2I+R7sqSH653n
	hLYR2YrUO/hzPTbj0vJa0TmH11SPhLYUsD2l3EvNSzemmczTeT4keXJ7t9fzMv+hTY2YjbGm2GR
	3XLsdsxKIzJywQvzfSMDJEFc1OaTKp98mCs6E734YZCPOJ3KboEINa9+wWsnVLLvSl3gshnsJUS
	iRUaATC/HP/BqB/O6Iz9tE0crM4GYXYjCpVpR/sHNXeVN1abHPcsNh+KwfEK3f6JG2zTabWyAYh
	sKzSGvB86IxQhbvdWJEr1ZgjaWKiedVkr7m1JcVCk+KnrsASd/PlLo5O5VBRFTfexJ0pinqWHOp
	LtlfwP3YHOj2g=
X-Received: by 2002:a05:7300:e402:b0:2dd:6937:79d5 with SMTP id 5a478bee46e88-2ed3d5c6b8fmr2496713eec.8.1777584641143;
        Thu, 30 Apr 2026 14:30:41 -0700 (PDT)
X-Received: by 2002:a05:7300:e402:b0:2dd:6937:79d5 with SMTP id 5a478bee46e88-2ed3d5c6b8fmr2496677eec.8.1777584640462;
        Thu, 30 Apr 2026 14:30:40 -0700 (PDT)
Received: from hu-jjohnson-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ee38d79eb9sm2504861eec.8.2026.04.30.14.30.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 14:30:39 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: tj@kernel.org, tony.luck@intel.com, jani.nikula@linux.intel.com,
        ap420073@gmail.com, jv@jvosburgh.net, freude@linux.ibm.com,
        bcrl@kvack.org, trondmy@kernel.org, longman@redhat.com,
        kees@kernel.org, pengdonglin <dolinux.peng@gmail.com>
Cc: bigeasy@linutronix.de, hdanton@sina.com, paulmck@kernel.org,
        linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
        linux-nfs@vger.kernel.org, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org,
        netdev@vger.kernel.org, intel-gfx@lists.freedesktop.org,
        linux-wireless@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-s390@vger.kernel.org, cgroups@vger.kernel.org
In-Reply-To: <20250916044735.2316171-1-dolinux.peng@gmail.com>
References: <20250916044735.2316171-1-dolinux.peng@gmail.com>
Subject: Re: (subset) [PATCH v3 00/14] Remove redundant
 rcu_read_lock/unlock() in spin_lock
Message-Id: <177758463946.1848985.4916088351427792183.b4-ty@oss.qualcomm.com>
Date: Thu, 30 Apr 2026 14:30:39 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDMwMDIyMiBTYWx0ZWRfXzxNL8wTmdbS1
 J5swR28fj1hWajfF+pCGCrxT3QrenlG8t2OKi1XN5mgYb6inZYuz8fEZ3pzE0eG7M6lL6mhStCX
 NT1eSP8FURsqR5dOKDWnANriTLzTmFCNIWUwfenlcNjcKglIxREJlgFzrkVpT1j6wyherAKmNKw
 W/Ay7WsSse87AIPA9yd4x81F49638O8gn4nxwhkFcmKuVXJ0fuYC9pgiA5uD42nukRESaoffX2j
 b8CzAyZRcxNagHfXo/3qzSuC0xl0DrHYDyUZbigIc95RybtONppsgTGpgWWfV1/YpibP8/sikVP
 8pOTkvKyNhzh1xZqhyAKW74ep+5yn6lcKp4d0JElpO+jitQE0Qelx9AfVDMW9/Rc9bqD8W/hERJ
 2bMZ2DkXH24JrHCAuWkjsG4TC129kBGrW4WDoPo54TIg4Tf5n6MbQdXWnjqM2NzOft4xfhvTac3
 D8FJcYukBrXVP2xSWAw==
X-Authority-Analysis: v=2.4 cv=Zdkt8MVA c=1 sm=1 tr=0 ts=69f3ca02 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=R8he2_Gm4Sd0DFq6ycoA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-ORIG-GUID: 6_GgmDSLKs9ATuqe4k4SqQEJtPkXfa-l
X-Proofpoint-GUID: 6_GgmDSLKs9ATuqe4k4SqQEJtPkXfa-l
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-30_06,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 clxscore=1011 lowpriorityscore=0 impostorscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604300222


On Tue, 16 Sep 2025 12:47:21 +0800, pengdonglin wrote:
> Since commit a8bb74acd8efe ("rcu: Consolidate RCU-sched update-side function definitions")
> there is no difference between rcu_read_lock(), rcu_read_lock_bh() and
> rcu_read_lock_sched() in terms of RCU read section and the relevant grace
> period. That means that spin_lock(), which implies rcu_read_lock_sched(),
> also implies rcu_read_lock().
> 
> There is no need no explicitly start a RCU read section if one has already
> been started implicitly by spin_lock().
> 
> [...]

Applied, thanks!

[14/14] wifi: ath9k: Remove redundant rcu_read_lock/unlock() in spin_lock
        commit: c4f518736472c8cfbf1d304e01c631babd2bbf34

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>

