Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.135.74
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793660078;
	b=287nkCDB3adTZI1ZxKdVsdq9Xdw3jFMlXqODuB31ARqoJNqDzGJ74nGxH6tNwgcNsI3y
	 kVcui2PNbuIdPdN2NgU1o+Gt+gQZnp65023DSQ7CLmMxG3li9eIGDCx8eMMF8T2T88Xx9
	 9NZKzaj7RGtylpaKkZWJFggyrR0o+UI1sf1s/lGGAPQEIYGCzjxITJT8Yp+VFK15jq3NX
	 Bv/D7rsnDG+auCdoKxXOixYm0pfjbwkOnT/UYYizO6i9Oe09Q4UdxS/6HPNhDZPZr/Sry
	 wA1TwDN3S+7rmcWaMu12mSdHxwKaUFdLhjRLuVhxj1ryRAPWd8vPRtgcQNNQz144+vA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793660078;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=JvhSK4+erTYH8YIOH2eSd/nyRcOBtvC7PXAApDZRJSQ=;
	b=oBjNFfjLiAahKFt9FSxtcu7/hilqaVLo2w8ofW9jhygW+DLt41NpFQYQY2uwGQRuKQ4b
	 EEMR85oh3Wd211sFxzybOnxjIKIgV+nykhPCZB15j2RTjaBfhRdv/qFDHk7uEjq/sZxQ3
	 3D9IaSq6oQIPKBbQDaPkdPEOTnfE+os25vYSWCUFk1rlS/ld0c6xzwFeBQj9/7CXg7lF+
	 a+0aAO6tJf7huY3s7QVp33BL9Dey8lVWdeadXabGqn4hf4YuU04LPoGrJIANpsa3s5i/E
	 10HvFXBbQKXycNkmxi2PG/xmJR5ZSu4Bf1s6kYMqPFFclobm078FRynydEhNqFzZW/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=columbia.edu;
	spf=pass smtp.mailfrom=columbia.edu;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=tZFtirQu;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=CeCPiNda;
	arc=none smtp.remote-ip=148.163.135.74
Received: from mx0a-00364e01.pphosted.com (mx0a-00364e01.pphosted.com [148.163.135.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFC7A606A338
	for <linux-fsdevel@vger.kernel.org>; Mon,  2 Nov 2026 22:54:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CFC7A606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=tZFtirQu;
	dkim=pass (2048-bit key, unprotected) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=CeCPiNda
Received: from pps.filterd (m0167069.ppops.net [127.0.0.1])
	by mx0a-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A2LY8ua3941423
	for <linux-fsdevel@vger.kernel.org>; Mon, 2 Nov 2026 17:54:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=JvhS
	K4+erTYH8YIOH2eSd/nyRcOBtvC7PXAApDZRJSQ=; b=tZFtirQuExq31bYlA6vL
	pcvRyF8+kFc7DPxZsbDjjVFgCknrsQOJ/YCBOg+i7kcmQ4pSW9ycDbX4aOgqRPoK
	TOpazxssr4ws8ECg2S7X5BcJ7dpEhbBe3dvvzcpylWIXTAkGgDJzLD3R0R3Gr13I
	v11zHaRvIy1hTqr1fuQi/zEqsp8tYbR+X0xVKWWcVDJ0W4pdrwDwQ0y5SscjjGBx
	P2ynUjNatgKSyne0N8PGs7LQrUfCinK336Bpq0UKtl9zWm0JoT6ESwOb4RLv+Pnx
	RtCjB+ybb3yOr2V3vsMkR4zzlAiM7box6zZFrI0IdKtvjsiOZlqjQpigynDbKrKj
	5w==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 4hptgqds0h-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Mon, 02 Nov 2026 17:54:37 -0500 (EST)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-93f5844e383so574414685a.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 02 Nov 2026 14:54:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1793660076; x=1794264876; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JvhSK4+erTYH8YIOH2eSd/nyRcOBtvC7PXAApDZRJSQ=;
        b=CeCPiNdaBbuGo1KN4AwNkILJu8t9ksjkeXiKJ6HuTHtTEiWAK6OLxk+J5I+t+q15/a
         W68y4l5YiY7J4UjlzTIFfWnHqqGh9sKrP0T7+KeXpqkdCUkL2jrI9w/acKRFQhWf1FwH
         2FeKR9mu8558OMW7LnUjqRdSUYD/AEUAU7jo/J7UG0H/rqOfHIyZlDkqgLJLeybMH2KM
         ZJSIPOckagq+mZ9L0KhnDC1Lu9jyebevTSHsO3beq/wM8Q2kyYIMPV1bOyWBJ81wWGs4
         jzjngJjerBvYpAqT626Z+FyUIMXw4/WVa8e3g+FEIo6mzBq7JI0lNk88ezqSsFlnk+TL
         Sv6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793660076; x=1794264876;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JvhSK4+erTYH8YIOH2eSd/nyRcOBtvC7PXAApDZRJSQ=;
        b=rGsurg2CsxpW1Pu82qacysi4Fx8A4gtyh286U3jY3WBM7Pya7YoLP89lGWWEYAKCKa
         Yi64xKT9WaqMoBITwYOQ0DzhGb1XIKdOZg6A5tZGUdtmjJs6iwAAVkVViKOHR+BENyKa
         yFq1Yi2yzptty15zyfq1vNOfLKl6sxj6/6YbCm1UZ9SL1l6goiUCg31uDfO4CNCxvpiY
         rT/v0G9V5SsBKQ43TI1fLB/Hyc0fV0q/Ffr6s49FPc35D0opBg+zOzkGJIkNSwXTu5gI
         pO618hNbsd/UrIQg6CWltkITo9JH81/gb0bpzN1ouPkSRxGqS1AF3J0d87bjyIQCRWgp
         YlMw==
X-Gm-Message-State: AFq9FYLO+hKlMvDuurj/J41GL7t+dlbR3CV+WjRN5tKbMORdpQQLwilH
	utOeyl3Uo60vlFshHhtGhU3b5ZLaZ2pewKDs2t4EGLDdGvgpsUi2HILpk99zzlLnT4SW1wF76hi
	Y+QvKE0XRyMJQtG/3RGVjsotUODCFDG2vfr8k1KQ7AdJT4n9KhMe1wzyiX1U13uo=
X-Gm-Gg: AYBFou1ANOSe19wh19zTblAzRo+IIKKI6Fx5Ave0Ps9eSkx+1NnUUM9gd3ymLp8rt8D
	2kLBzcFcm462eHgd550pObyWaDqVnuxzVZk8Xf12ewGr5wvQW/UrPFvni7CfuPo17v+laJ5H651
	2U0a4ewVLJsgyUvu/ibGNdsIf4mI3eOoFHetotw4KEY/Polb4Ru+zIRoKLXKiIhuCqUAecbveYB
	iFjttriLYlR15tmWQm1WiZvbXe99S1GgHkmmLi4a06JFiPI9EUaZaJxuxGWjlxFZzCrdtAXiGZg
	THs+u1oRbbdsz97irBOutFe7va17nCe8HEJr1e0G9qgt+lDV/pTU0TqNAXzOdy5M4Ao2SOjmOQD
	6347ywcCmI7ukMLaFgdo0Bl+vVHKsMAVRRwmUfqZhVaC6UegQc3I/XaH6jC4=
X-Received: by 2002:a05:620a:4686:b0:939:feaa:949c with SMTP id af79cd13be357-944216bc9f1mr1945417685a.36.1793660076001;
        Mon, 02 Nov 2026 14:54:36 -0800 (PST)
X-Received: by 2002:a05:620a:4686:b0:939:feaa:949c with SMTP id af79cd13be357-944216bc9f1mr1945412485a.36.1793660075493;
        Mon, 02 Nov 2026 14:54:35 -0800 (PST)
Received: from [127.0.1.1] ([37.142.157.119])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71b8011csm24710529f8f.31.2026.11.02.14.54.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 14:54:34 -0800 (PST)
From: Tal Zussman <tz2294@columbia.edu>
Date: Mon, 02 Nov 2026 17:54:09 -0500
Subject: [PATCH 4/8] mm: remove attach_page_private() and
 detach_page_private()
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261102-page-wrappers-v1-4-e7280bdb31f6@columbia.edu>
References: <20261102-page-wrappers-v1-0-e7280bdb31f6@columbia.edu>
In-Reply-To: <20261102-page-wrappers-v1-0-e7280bdb31f6@columbia.edu>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>,
        "Liam R. Howlett" <liam@infradead.org>,
        Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Zi Yan <ziy@nvidia.com>, Matthew Brost <matthew.brost@intel.com>,
        Joshua Hahn <joshua.hahnjy@gmail.com>,
        Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>,
        Ying Huang <ying.huang@linux.alibaba.com>,
        Alistair Popple <apopple@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Tal Zussman <tz2294@columbia.edu>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793660051; l=863;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=Bq8LYY+n/Ay+89r1G5Eo/k9gxFa6AOfJWAM1sU3Jypo=;
 b=hGYmgc8vvXeTe54e3g23M49eW7JIDcFpSj7RhwWomEDSjn+AGWW8KxWJXr1BemK/D3QZZh6pI
 hS1h5YT70HrBFbsaj1666ot45sEpLJeSQSECMF3m1N/8eaO5Uud1KEC
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-ORIG-GUID: fkL2RY_tAVIyKkMJK2Ef4GAFZ3wIe6xW
X-Authority-Analysis: v=2.4 cv=B+osQ+tM c=1 sm=1 tr=0 ts=6ae914ad cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=Qz3frfIdACK70Hl/8c7MJg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=JR4YdQiviy7OQf72WyZ1:22
 a=utpKXwlFHvWpKPHLcNIA:9 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDA5MCBTYWx0ZWRfX5hM5eP6kvNPd
 QEgu3W5e23BxIIW5s7gBaV3ONxZcy5fHjdGA8FA2J1Kxq9tVKCJc/EO5a8HAVjsAIUODwAXCERu
 GInasTetCMUdaGNMRG7nGsvCVUrgst3F9ckG30LP5ke+emSQY89j
X-Proofpoint-GUID: fkL2RY_tAVIyKkMJK2Ef4GAFZ3wIe6xW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDA5MCBTYWx0ZWRfX6fo3fn4lGLAp
 Ny0LZgbGXCikS7iBhuRrZl5XuxYmFHhmWKOgk0GEuvNjpNKy6mm1OuVE/K8mv5jzUtIl3QU3GK3
 0KuSCX7awyvsCiBm9UVT/Wt7kRSWt6wtYseGq+aouwW0VlwYg+26obBeEmCz7Onqjw9w7wJ/VeL
 CbkmBS3V05ateT48zEBc8eiiUg6ePBt39OrQLlL39NNEPiRG0IKkQHTP059kfZMHneOY5WfK19g
 gKuOFLqH0ffl/rUAh0E7gRM0QU8KJDo3E+6ZYOpvbdqbPzBGgpclxWgo36ahu/zVmI99u3k5599
 Ucg0D6KcXI4G+Jy878yVrcIxbzxXSX7/jXUgzSlLNtiz7v7D5nrkryMH6+Q+hEBqEu8YK15rSnk
 zWzofOn3z5Qzsdj6pPwtpIRK1Vtc4d6GRlBglrR6wDcPqLwEUZspm9USDbfELo7s+70/ISd2q0p
 RT5FVa3eqVXdSagLhBQ==
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11954
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=10 clxscore=1015 adultscore=0 lowpriorityscore=10 impostorscore=10
 spamscore=0 malwarescore=0 suspectscore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611020090

There are no callers left of either wrapper. Remove them.

Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
 include/linux/pagemap.h | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 9adfeae2153c..37b7786350c5 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -635,16 +635,6 @@ static inline void *folio_detach_private(struct folio *folio)
 	return data;
 }
 
-static inline void attach_page_private(struct page *page, void *data)
-{
-	folio_attach_private(page_folio(page), data);
-}
-
-static inline void *detach_page_private(struct page *page)
-{
-	return folio_detach_private(page_folio(page));
-}
-
 #ifdef CONFIG_NUMA
 struct folio *filemap_alloc_folio_noprof(gfp_t gfp, unsigned int order,
 		struct mempolicy *policy);

-- 
2.39.5

