Received: from mx0a-00364e01.pphosted.com (mx0a-00364e01.pphosted.com [148.163.135.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C93B9373C0B
	for <linux-fsdevel@vger.kernel.org>; Wed, 20 May 2026 21:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779311849; cv=none; b=e8A7YiP6yECPnXyKww6Ua00UbtnB3KaHupcX43u2wlAeD85CRZGoOfb2g2LWiq9q3xhJIUW65pYq4Mw4VT0TmQhwAGBMexpnDRnGWWue6YsVGJvv0DhqpY18CFD9VbAYbMFPppyuu22bhbUVECn4OhkfsZ+X0o0GVTMj9krl2+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779311849; c=relaxed/simple;
	bh=Ef/ox1MkrmElyb0ePApsHswo4ob6Yz2fS7lco/9GCj8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=aMFNQXRRQ++vMCpy2LRWOX7TKRagNYKkoo/GPhN8Vc+H2eKo2unLDJZ+4xEZuA75APWDCx8H9EDTzsv4UvWDrzTsFUfdlqrtGj1sTm7bB06qploPGf5C0ALal2mu9ZG+NmDYI3W6G64pZqBtj/tW3vBqYu9oiEG5PZubGST6EuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=qmMFAvIg; arc=none smtp.client-ip=148.163.135.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="qmMFAvIg"
Received: from pps.filterd (m0167069.ppops.net [127.0.0.1])
	by mx0a-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64KKO3GX708911
	for <linux-fsdevel@vger.kernel.org>; Wed, 20 May 2026 17:17:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pps01; bh=CS7fM6BsOopDINyqT3OZ5FZsRH
	Ek/OFvQe3cQMzT+iE=; b=qmMFAvIgwUAYYbpvJanCtiML8b+Q01CKNCWwlVzyhc
	bp7DnAnwxXFJ25RAPkPhcZ1WeGB0n3/zZ2Z1yjupz53n5VYZtjKqsHL9N2mhC7zO
	soaSwo86waDmRqw572oI5r4d0qUoHtPyvRi7jXSnFj7lAmcAX0D0fqxptu6UKN/f
	VzSs0GG+zoGnydbj306etqXEQAeFPFyTaJ6Wc3oQHkGHgJDVxYyxWQYhP0w+y5hg
	PqG2ROj85EHxMkmHErYTyIoi5dM6y6Bm7G/6e/jPupzv9Aj+sbP469/AV9GGUCVc
	TUhWEKZzQgpq7ZzPP3nZ0JZezSDc8pXO/a0ekM6DyySg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 4e99ydd74f-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Wed, 20 May 2026 17:17:27 -0400 (EDT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-911cf6eb48cso1269849885a.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 May 2026 14:17:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779311846; x=1779916646;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CS7fM6BsOopDINyqT3OZ5FZsRHEk/OFvQe3cQMzT+iE=;
        b=aMXePEJ6igbPg6yBraQbmBrtZu7d3Hq/2c/qceDRwgnhAw2VlpM6Enm0And99F7RWK
         IkhLuuGhnYFDPmM8h6o/QFFekTidhqhrrZ52FURsxoWgqbjJRTN68ITUWALEmdz8/V+e
         rZmVx9MK/7fiOxGSMUlpL+kDY4qWEZEGHmiWYkhNyaRgtjWzwkqlWsjnxJzAV/U7uisK
         gDBpbbsZbvWLpuxx4ZX8R/jChKxbugFpvB4o1Wf3Z4LorpMYnij2ozyZ4OehPT5P5tFu
         9odCYen1GR6Yk5srsXkR5j3meyY7Q8g04CMDnLHTzNzOtPc3ruClXT9VqzifURGuodcB
         wkNw==
X-Gm-Message-State: AOJu0YxZ94OeHOiEffrpAONbTS4a8QzHZA0guEMsLkd6ps3tJIfy93Bb
	4/UiEdZCMGDSLawD1dIDprK+V1X6mDdBycZMPpznUYMU632004PjsfMB5Rr+EdZHz9PSOcOK/Gc
	IQtLGzW9YZvhybhvmVKguyYpM7ek6mb/relCIgYxeHHLcwrB0f+J25IfY1nD6QMo=
X-Gm-Gg: Acq92OGkKcJVDbHnhINhwGBzNv9B1b9CLJZgquZmV2+BoDdJWqZ6wshu/AdJVSB4Wv9
	OpSkDawEFEHL4JHnbB9wQ9YmFbrnGOsU/wDw+umFkU25VTBL6UgTrZ3i21oue3eUoAEgUmK1O4g
	7M0WbXAHoD0D29wW58Ef/XTBGWwhAKBKm9Rm4/xnGjGQUzBsMEIVKMC7qMi6iU286OB5zqFxUn0
	1hGd/SJycSnCqAlaEIoFPoxmt1JquX8YzdebwrAIRld7vN4Q7GGaFv1tDfDXYktahp8yzVeXES+
	dpXz7e52BoSLOmJT/s2zqEURH4v5IUJEIDPJp0G52GRcXeUCpw4oAq+fPd5F7uqXP1c5wKno6tr
	JOxrbgXxEt/yC2ltpFSiuDQTDhmr1zNDEDDLL9gjwvn2aHmy5XXrkY98qF2UT5ZCjFPaWf8RiUZ
	ZFQw==
X-Received: by 2002:a05:620a:c4d:b0:90c:c513:2b12 with SMTP id af79cd13be357-911ce046f54mr3721480785a.18.1779311846012;
        Wed, 20 May 2026 14:17:26 -0700 (PDT)
X-Received: by 2002:a05:620a:c4d:b0:90c:c513:2b12 with SMTP id af79cd13be357-911ce046f54mr3721475185a.18.1779311845570;
        Wed, 20 May 2026 14:17:25 -0700 (PDT)
Received: from [127.0.1.1] (dyn-160-39-33-242.dyn.columbia.edu. [160.39.33.242])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ca3619c703sm133165916d6.33.2026.05.20.14.17.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 14:17:23 -0700 (PDT)
From: Tal Zussman <tz2294@columbia.edu>
Date: Wed, 20 May 2026 17:17:12 -0400
Subject: [PATCH] MAINTAINERS: Add more files to PAGE CACHE section
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260520-page-cache-maintainers-v1-1-f93438d2186d@columbia.edu>
X-B4-Tracking: v=1; b=H4sIANckDmoC/x2MQQqAIBRErxJ/naBCgl0lWohN+ReZaEQQ3b1Pi
 7d4D2YeaqiMRmP3UMXFjY8sYvqOYgp5g+JFnKy2Tg9WqxKkxRAT1B44nwJqUwYmwnl4aEsyLhU
 r3//xNL/vB/pmWPVoAAAA
X-Change-ID: 20260520-page-cache-maintainers-1e1ce69e9e02
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Tal Zussman <tz2294@columbia.edu>
X-Mailer: b4 0.14.3-dev-d7477
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779311842; l=905;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=Ef/ox1MkrmElyb0ePApsHswo4ob6Yz2fS7lco/9GCj8=;
 b=01utyJA+a/1N+AsvU3SA32mhxWRYC+s8KZFxjq0nijNw6Pl0Etcfwn12/pQLLx5TW1HweczKB
 uRnjHtnHT3GChQoKqsflogvyQ07uIrzwEogNkqhIBX/B83oQcUUH/4Y
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-GUID: UNQlmJ_wOq2BB7ss1WlEOKVGY4n1XwA9
X-Authority-Analysis: v=2.4 cv=TbKmcxQh c=1 sm=1 tr=0 ts=6a0e24e7 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=GaPK54s0Se3oFqK5NkZy0g==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=x7bEGLp0ZPQA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=JR4YdQiviy7OQf72WyZ1:22
 a=JfrnYn6hAAAA:8 a=eHGkg-NUNoCaPWi8_isA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDIwOCBTYWx0ZWRfX5DiZ3t/8dmBP
 3yvMbFok6Ymt4Po1aPGXQIgZOZaSZhYPKWaE9PXrLK9X8UPoqm01jetG85XdWdimTsK68ZLkuxp
 wr6ZsSrlFHYrE2NABTrKh6msV2vbhXZU3y+FY4NtbdCwz3Lyc15CLEnMLqqlrOko67Ibn8TIkT5
 TB9Qg+EszjsLixnlXlLvCwmV9SKXitPnCSbfDnhaThoLLEXtxLN4ujBQrvMgY5BPtMZGtHvdT56
 6CbX0ptoA1vq12cOzU6mi9wp+1Jn3zYMHEGnQVTVvdjzHXHVP3LmN+tAyEd7gwXrrPFg/j9T8zA
 P4JQOC6zrcb+hopgzpiORUCLlSECf4lT/c5FzMXyaF1Cz2xZ5ywFdJfJa8mpy5AFClUvk/epaMr
 yYrrNlADQ2Krw+yudju9oDCh8sc0PPzjeLheN0XdhlPaZaKXkdt+fekYCnJUNCMai/4S0KN6/gE
 7iQRhQkIXprZ0j+sF6A==
X-Proofpoint-ORIG-GUID: UNQlmJ_wOq2BB7ss1WlEOKVGY4n1XwA9
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11792
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=10 clxscore=1015 priorityscore=1501 bulkscore=10
 suspectscore=0 malwarescore=0 spamscore=0 impostorscore=10 phishscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605200208

Add include/linux/writeback.h and
include/trace/events/{filemap.h,readahead.h,writeback.h}.

Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
 MAINTAINERS | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8cf9ba51d981..b7942e036775 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20172,6 +20172,10 @@ T:	git git://git.infradead.org/users/willy/pagecache.git
 F:	Documentation/filesystems/locking.rst
 F:	Documentation/filesystems/vfs.rst
 F:	include/linux/pagemap.h
+F:	include/linux/writeback.h
+F:	include/trace/events/filemap.h
+F:	include/trace/events/readahead.h
+F:	include/trace/events/writeback.h
 F:	mm/filemap.c
 F:	mm/page-writeback.c
 F:	mm/readahead.c

---
base-commit: e9add7501ad3297dad9b90ce201266830a68ab47
change-id: 20260520-page-cache-maintainers-1e1ce69e9e02

Best regards,
-- 
Tal Zussman <tz2294@columbia.edu>

