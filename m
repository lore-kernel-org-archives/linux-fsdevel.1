Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=124.126.103.232
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793441841;
	b=xLmFKxj0OTLjFxyOoferfM9F3gurWyGjvg1EY7rFVtIvsfBr9CkgdEBOuV1YZgtCfBpT
	 T3LfcXlduNPyzzstdQKDB54rk9mgWEMeMnlRyq635WXR6b4+8TZjHcC4u6wlzfDn5rJPC
	 9en5mk8g25Z0QBO/0y15mgt053Irtpagi/OwMLO/6YnGSlTiHnV6uJDRLrJslgwCLMI7V
	 unqZ/f/2AJihtaKjpZHoo2xxvyfj+Te2At0RvdM33NfmxZTGLD4c8V/5ECscUsi3qXyLn
	 OpHj1+Tmkecv77OKOYtvl+K2p4AYnxmTR3JzGoFNHBeFOf6MBq5t6PAG4w3CyHZiOog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793441841;
	h=DMARC-Filter:X-UUID:X-CTIC-Tags:X-CID-P-RULE:X-CID-O-INFO:X-CID-INFO:
	 X-CID-META:X-CID-BVR:X-CID-BAS:X-CID-FACTOR:X-CID-RHF:X-UUID:X-User:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=+hK+CT14oZ0X9dMr1eoY8PLrTY71QuWo7rMzXyf33Ec=;
	b=uADf40zaYBSYOff6l88LDLPCrhLZAp7NH0kisCcAafBuXdR5bai7dzXhky715SydmH6J
	 +9C4vjKswRkTQCJMu4TZ4Pny//cf0VGxDG8HsfWzwlmNiTmnZJKWDMnSPzSQAdFhARGHd
	 r6MXWuv+n3WNjmKOLFpUjCxxYYz1QE8ogyFQcdkSawkcdTjitaJ52W+c8ePgfwFWCMnVn
	 /nE+2Kp2nykqU8b5xW9mlT4psdC6/xsty36ZjXERCxUYFV8gg/oJ4XZ1GP55McVFyEgva
	 F/TmTIOAdka2Ewb1xDz4+H0OirmOFI1DLf53neX8lnAIm0T3mF1oQdi11JZ6S4l3RCQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kylinos.cn;
	spf=pass smtp.mailfrom=kylinos.cn;
	arc=none smtp.remote-ip=124.126.103.232
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21AB7606A31A;
	Sat, 31 Oct 2026 10:17:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 21AB7606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 3c205f26d51411f19a56ed5b684f684d-20261031
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_DIGIT_LEN
	HR_FROM_NAME, HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER
	HR_SJ_NOR_SYM, HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT
	HR_TO_DOMAIN_COUNT, HR_TO_NAME, IP_TRUSTED, SRC_TRUSTED, SA_TRUSTED
	SA_EXISTED, SN_TRUSTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS
	DMARC_NOPASS, CIE_BAD, CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS
	GTI_RG_INFO, GTI_C_BU, AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:53b4c4bd-1434-4885-b910-329b736392c5,IP:10,
	URL:0,TC:0,Content:37,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:72
X-CID-INFO: VERSION:1.3.19,REQID:53b4c4bd-1434-4885-b910-329b736392c5,IP:10,UR
	L:0,TC:0,Content:37,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTI
	ON:quarantine,TS:72
X-CID-META: VersionHash:7db8b62,CLOUDID:e43b9f5b8de7744da9526a2d0acc7c8b,BulkI
	D:2610311817137CTBOW59,BulkQuantity:0,SF:10|66|78|81|82|127|865|898,TC:nil
	,Content:4|15|50|99,EDM:5,IP:-2|1,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BE
	C:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ASC,TF_CID_SPAM_IBB
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 3c205f26d51411f19a56ed5b684f684d-20261031
X-User: liqiang01@kylinos.cn
Received: from cvdaxia.localdomain [(116.128.244.169)] by mailgw.kylinos.cn
	(envelope-from <liqiang01@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1034254473; Sat, 31 Oct 2026 18:17:11 +0800
From: Li Qiang <liqiang01@kylinos.cn>
To: Christian Brauner <brauner@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	Mateusz Guzik <mjguzik@gmail.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	liqiang01@kylinos.cn
Subject: [PATCH v2] pipe: avoid an extra kmap round trip for short copies
Date: Sat, 31 Oct 2026 18:16:45 +0800
Message-ID: <20261031101645.912671-1-liqiang01@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261030-almosen-kaleidoskop-alpinsport-aa25b8e28d7b@brauner>
References: <20261030-almosen-kaleidoskop-alpinsport-aa25b8e28d7b@brauner>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

anon_pipe_write() requests PAGE_SIZE bytes when copying into a new
pipe page, even when fewer bytes remain in the source iterator.
The iterator copy is already clamped to the available data, so no
data is copied twice. However, after consuming a non-empty iterator
with less than PAGE_SIZE bytes, copy_page_from_iter() enters its loop
once more and performs an extra kmap_local_page()/kunmap_local() pair
before the zero-byte copy makes it stop.

Limit the requested copy size to the remaining iterator count so that
the loop exits after copying the available data. This is a performance
optimization; the copy semantics are unchanged.

UnixBench pipe results on Hygon C86 7490 (Hygon 4):

| Threads | Before | After | Improvement |
|---------|--------|-------|-------------|
| 1       | 835    | 854   | +2.28%      |
| 256     | 179293 | 182895 | +2.01%     |

Signed-off-by: Li Qiang <liqiang01@kylinos.cn>
---
Thanks, Christian, for the clarification, and Mateusz for taking a look
and supporting the change.

As Christian pointed out, the iterator copy is already clamped to the
available data; this change only avoids an extra kmap round trip. I have
updated the subject and commit message accordingly.

Changes in v2:
- Reword the subject and commit message to describe this as a performance
  optimization, with no data copied twice.
- Explain the extra kmap_local_page()/kunmap_local() pair avoided.
- No code changes from v1.

 fs/pipe.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/pipe.c b/fs/pipe.c
index 292425a834dd..da5583f7f37d 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -595,7 +595,9 @@ anon_pipe_write(struct kiocb *iocb, struct iov_iter *from)
 				break;
 			}
 
-			copied = copy_page_from_iter(page, 0, PAGE_SIZE, from);
+			copied = copy_page_from_iter(page, 0,
+						     min_t(size_t, PAGE_SIZE,
+							   iov_iter_count(from)), from);
 			if (unlikely(copied < PAGE_SIZE && iov_iter_count(from))) {
 				anon_pipe_put_page(pipe, page);
 				if (!ret)

base-commit: 47324d3a5b3abd781295044d01d92d09f184e872
-- 
2.43.0

