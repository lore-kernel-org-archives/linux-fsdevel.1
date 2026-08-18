Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E8081474CC;
	Tue, 18 Aug 2026 01:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787015126; cv=none; b=r6WxPTj64aAbr2pzqLjdkkHedxokNXIrSKFm+xEpbPdnNOqRldv1NTxkPjn7O+6QwgccA6FEAEXJ7zngzXmlH22hNfW/m2iON3iYe4BzbmsDre4YSh2JNYxXe2wf/MZ2fg7CN9NdJ3oIuVoY+5PhtIaJW/LnzOWEymExQwfmrNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787015126; c=relaxed/simple;
	bh=lAzzXRau8yR7Q2xGJdlV6Al3vi/XbA0PxLpHrFl4O3I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uqY0YYa2uD5JYJIYBzei4mUvMDdhYXP/ymWZnm2arjFVyTBX/pP+bqghpH9u1b4S6uCMNiA2kCp+zprVfktBEJUN405Zzq6UXuvP4d+ynC6wCzb6XZst0uv7X+jTPyg1j/L6sNWlShC/o8bVPCGjevICyXBJiin0UHNeTW8NkhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: de1bf62c9aa011f19a56ed5b684f684d-20260818
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NO_NAME, HR_CTE_8B, HR_CTT_MISS
	HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME, HR_SJ_DIGIT_LEN
	HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE
	HR_SJ_PHRASE_LEN, HR_SJ_PRE_RE, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NO_NAME, IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_TRUSTED
	SA_EXISTED, SN_TRUSTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS
	DMARC_NOPASS, CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS, GTI_RG_INFO
	GTI_C_BU, AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:67336774-f8da-4d01-b25d-312dbc6da10a,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:10
X-CID-INFO: VERSION:1.3.19,REQID:67336774-f8da-4d01-b25d-312dbc6da10a,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:10
X-CID-META: VersionHash:7db8b62,CLOUDID:2426a112fd7eed1304d354514c774d3a,BulkI
	D:260811205833BZBX3QXG,BulkQuantity:1,SF:17|19|64|66|78|80|81|82|83|102|12
	7|841|865|898,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bu
	lk:40,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0
	,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: de1bf62c9aa011f19a56ed5b684f684d-20260818
X-User: husong@kylinos.cn
Received: from ctao-book.. [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <husong@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1340971763; Tue, 18 Aug 2026 09:05:13 +0800
From: Song Hu <husong@kylinos.cn>
To: ye.liu@linux.dev
Cc: akpm@linux-foundation.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	liuye@kylinos.cn,
	mhocko@suse.com,
	rientjes@google.com,
	shakeel.butt@linux.dev,
	husong@kylinos.cn
Subject: Re: [PATCH] mm/oom_kill, proc: replace magic number 1000 with OOM_SCORE_ADJ_MAX
Date: Tue, 18 Aug 2026 09:04:33 +0800
Message-ID: <20260818010433.65169-1-husong@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260811033609.3992348-1-ye.liu@linux.dev>
References: <20260811033609.3992348-1-ye.liu@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On 2026/8/11 11:36, Ye Liu wrote:
> --- a/mm/oom_kill.c
> +++ b/mm/oom_kill.c
> @@ -230,7 +230,7 @@ long oom_badness(struct task_struct *p, unsigned long totalpages)
>  	task_unlock(p);
>
>  	/* Normalize to oom_score_adj units */
> -	adj *= totalpages / 1000;
> +	adj *= totalpages / OOM_SCORE_ADJ_MAX;

One thing this line hides: for a memcg OOM, totalpages is
mem_cgroup_get_max(), which can be below 1000 pages when the
container limit is under 4M.  The division then yields 0, the whole
oom_score_adj contribution goes away, and a task protected with
-997 scores the same as a best-effort task with 1000.  The -1000
exemption is checked separately above and still works.

DIV_ROUND_UP(totalpages, OOM_SCORE_ADJ_MAX) would preserve the adj
weighting for small limits and change nothing meaningful for large
ones.  This is an edge case, so probably fine to leave as is -
noting it here since the line is being touched anyway.
