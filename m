Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29559171CD;
	Thu, 25 Jun 2026 05:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782366600; cv=none; b=PcAMew2S8HkC31Wi8lNdb0ZFWRbLuRz0UERlNmYAPG6bp69olxQxGk0NlHcOcDrgMoKPJhmeJY8aiC8GtUMqizgeuiyfTYPXKWkLJjURYBF/goNWw45G4oL29FJZlkxVISucaLwo/crJk6ToZxTnjhAAX5ZJ8jibEvEYzGgrzNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782366600; c=relaxed/simple;
	bh=ffyEPNM4/MroNmupf8+356jbswpbUjHbGc/OucLyHUU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kErs3Y1UnDCdthQyttgrHu4LF8SoQb3kzcQF3j59c/a7MfkPK1lSNlxrRkpZq1TQGJvQc/3I7SIQNb7GRRQEs1QSOf5X5660ZqFSXl9maeL1WWCCn7N0ZWwjW8BtDt/Xpzw8z+tmxW7EPGzKqGNu30BblEzX6Pbjj/WM17WXoi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: ae7cf162705911f1aa26b74ffac11d73-20260625
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NO_NAME, HR_CTE_8B, HR_CTT_MISS
	HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME, HR_SJ_DIGIT_LEN
	HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE
	HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NO_NAME
	IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_EXISTED, SN_EXISTED
	SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS, CIE_GOOD, CIE_GOOD_SPF
	GTI_FG_BS, GTI_RG_INFO, GTI_C_BU, AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:4a1fc58d-7937-40a2-899c-edc312cdc844,IP:10,
	URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:5
X-CID-INFO: VERSION:1.3.12,REQID:4a1fc58d-7937-40a2-899c-edc312cdc844,IP:10,UR
	L:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:5
X-CID-META: VersionHash:e7bac3a,CLOUDID:f653971d38e0eb93971b013d818d392f,BulkI
	D:260625134951C85J5I9S,BulkQuantity:0,Recheck:0,SF:17|19|38|66|78|102|127|
	136|850|865|898,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,
	Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BR
	R:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: ae7cf162705911f1aa26b74ffac11d73-20260625
X-User: duanchenghao@kylinos.cn
Received: from localhost.localdomain [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <duanchenghao@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1580749568; Thu, 25 Jun 2026 13:49:50 +0800
From: Chenghao Duan <duanchenghao@kylinos.cn>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	linux-fsdevel@vger.kernel.org,
	pasha.tatashin@soleen.com,
	linux-kernel@vger.kernel.org,
	rppt@kernel.org,
	pratyush@kernel.org,
	kexec@lists.infradead.org,
	linux-mm@kvack.org
Cc: jianghaoran@kylinos.cn,
	duanchenghao@kylinos.cn
Subject: [PATCH v1 0/2] luo support for preserving eventfd
Date: Thu, 25 Jun 2026 13:49:44 +0800
Message-Id: <20260625054946.73445-1-duanchenghao@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It is my great honor to participate in the development of LiveUpdate.
The current patch implements logic to preserve and retrieve eventfd
states, which I developed by referencing memfd_luo while learning the
LiveUpdate framework.

eventfd serves as a critical notification mechanism between Guest and
Host. During host kernel upgrades, we can preserve the corresponding
eventfd states and restore them after the kernel update completes.

Patch 0001 implements eventfd_luo, while Patch 0002 contains selftest code.
Test procedures:
    1. ./luo_test_eventfd --stage 1
    2. kexec reboot
    3. ./luo_test_eventfd --stage 2

Chenghao Duan (2):
  eventfd: luo: luo support for preserving eventfd
  selftests: liveupdate: Add selftest for eventfd LUO

 fs/Makefile                                   |   1 +
 fs/eventfd.c                                  |  40 ++
 fs/eventfd_luo.c                              | 250 ++++++++++++
 include/linux/eventfd.h                       |   2 +
 include/linux/kho/abi/eventfd.h               |  39 ++
 kernel/liveupdate/Kconfig                     |  16 +
 tools/testing/selftests/liveupdate/Makefile   |   1 +
 tools/testing/selftests/liveupdate/config     |   2 +
 .../selftests/liveupdate/luo_test_eventfd.c   | 376 ++++++++++++++++++
 9 files changed, 727 insertions(+)
 create mode 100644 fs/eventfd_luo.c
 create mode 100644 include/linux/kho/abi/eventfd.h
 create mode 100644 tools/testing/selftests/liveupdate/luo_test_eventfd.c

-- 
2.25.1

