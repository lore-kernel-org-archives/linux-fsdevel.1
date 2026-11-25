Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.227.137
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795575882;
	b=tBbYXyjDvEYUIiDGYLKu7LprTky3/XUw/m7S8iYgG3qTQFgHZq+UVTqZAwSUQTVFY6Pt
	 tdz2uUe8GKyNALC+J1BXdFoJ4oznysilCB/KBtSpHstp7OuXW/dsl4W+GNKHBWusF66A8
	 qZqnCqtRob1gcJU4utEwiYUUiYNCj4G4ggD2cwD3qoBmdHSD72GHR+jv5G74HC9apbN5Q
	 IF3Hn9GIDZuuiSUYVJW3vvaCYbsjcd8b4mSyrOwvi/Zz8KfulKIa1caMjevQmkSAH5lob
	 gIS5C0i/eh1Pa2T2qgLrMpKfLyESQ03XLBB359BrQzqok0WXNxodFTZTAIS8lXahMtg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795575882;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=eX4/tC2R5B5mthZ/Pbn5Ck0uCjL/h6zZMuH7cLWUB8o=;
	b=yySV8T9x1qv+eMSPzV13qolZwQrfq9uvWXAvwC99h8ZuCovoI4Wi8UT/8etBBjUmoX8s
	 99AxcDzO2UQGfIfic43GMLCsO//zeMTVt360TUZvXDNmavhSo+QmuzDem61gSOYR7/nFX
	 av3JOlW+zPrn6qswvvVnXKZuMoP7jwE3+G1JIpzcmAcDK91HEpbUJq5MInulY8kMWf+Hw
	 KY1lr95lnojaygbfkz7ZysyM3XhRUJoxlns+BJcvWmmAiz/+SUp4/DU7wOKBIBSbYQTal
	 s/8Yiv4twdNWsuV+VGMx6DSk7zWaDVkXSuldclHwFx9J2+GoTX0G4NQ67fNRZIkMYNw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lQY2HIew;
	arc=none smtp.remote-ip=74.125.227.137
Received: from mail-pj2-f9.google.com (mail-pj2-f9.google.com [74.125.227.137])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F7CD606A31E
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Nov 2026 03:04:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9F7CD606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lQY2HIew
Received: by mail-pj2-f9.google.com with SMTP id d9443c01a7336-2f06c2c371aso13197615ad.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Nov 2026 19:04:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795575881; x=1796180681; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=eX4/tC2R5B5mthZ/Pbn5Ck0uCjL/h6zZMuH7cLWUB8o=;
        b=lQY2HIewggLQ9uOUytsbHhnkrpqeWQrscIwbw0/Dx7RAPmFIZFsDKpkTsMgMzibMib
         zmU00Xrjx+aCoJAbH/oF4d1AQnOXRwGQByxv1Em8TNoe1ao/Izi/BQmIrzL/6OcC8WF3
         F40XaKFnC1n2TgDWFRMBZZohy9hzt3E8gv8ksIdjN5vh1Xu7/Xq7qwNi8GjY3lmWG1i3
         SPKYW4A8YznQuGF4E2tojwlWyz3L7j9vjuKbF+Ls2ttBDANT4wl+y+m/TP+VgI0E2YKw
         WMRn+T+7wYoEF0JNEeyA9npMqN5lN1EXn6EPKojEtLq+f0iRLL1GMwUEVXk/KcTTZ4jA
         YpzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795575881; x=1796180681;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eX4/tC2R5B5mthZ/Pbn5Ck0uCjL/h6zZMuH7cLWUB8o=;
        b=zXIF49+EsXpzLTnjqDNl0CK88/dRN2b3GjSILCtUAx4Xqlfdjp4FN1rtOHB5oioTsY
         QBvrB31PXA//vSBpm5NOVi9aipH25MPmpbmuxokitGj4oq1tqQp9YV0x8HOyoe51vtLe
         8+7htBGkAeRKPGVc2Esx1vNiigT3SybX8jf86IIpbt/OeGoeS07pXeyng/l7W5jLoTme
         T9+nJQH2z7es77o19qRpAgLZ/z0VlHYRMqtLNUqD/mAI7sZrizoNzPDmmmWi6TcIPxSM
         lhI4AOr6SIB9BBtMpJ8wrYtCVTD61Iu/ialZ01fPbiM+Eg+QMGDqHlmudIEYP6qVRNPw
         dmyQ==
X-Gm-Message-State: APuU4Z+vC43e+Cycupiu4QEDzlegi6jzTbabMnQ2t/cOUzm2vDnwWukg
	HvQDDlTlM6XTwpBNzCTpINQUXhS2BpdFVzRFImW4YGOf+qpzhKQeZjej
X-Gm-Gg: AZFdTZcZ2Mw6wRsduT7vPe0dmo9i31k+zZDuKN8nCFGeohV3TTnwuZqyyJuQVmFKzqT
	GfH4JNReW3F5JTl+9r+nb5eOvSt0DmQLDaEYfUptbinFL4kWyrCZkXKkouCxVA1CQWDoEyU8GCn
	URUZWeciz7E5dWe864Nj8PfkK3oM2XsHMR3K7fXShUX1A7AkaSqybfhE4nuzxaTPt25joGGwvBq
	bEn6YQO6pyVR75Jen8JYHzUvo2b9Ms+p0+IZbQ7+zURcyhlvtcXcaI+4FDqAF4M9l3rFHvGjI6V
	+aIr5Pl8d5Y4C0T7baX4aVMByfL39qGGABnT1BXqKWBGVmRe57OyXgkkdnhxeKcWqb993T8wW3N
	wLJgPM9tzZQRyb96qBT6eSd1Ujcer3w2hZQvZhIJeuLenos0t3ftJ1tnbuc5eJwxmmh0kulC4R/
	VVrAbvzgsDQXknuQIfWtuzeEWysOJNDO/smSyjDibzAn6l8IFGpkCX73ptTcYIOg6NpJl4thDXc
	FE0MwS0iUdNAACz5LitSoGMoN38k7O6eKiCdbHcpNzTv8XhY1eEwrjoiqzKy4mnMFe0gsUtg8Uj
	wIpwLMJH8Glt9mO1qw76aKbYPr2KLqcxvwjSMcOcEDcxMsfJRXawlqsaojt6zj13mK1TkSOn9g=
	=
X-Received: by 2002:a05:6372:a705:b0:3fb:3d85:ef60 with SMTP id adf61e73a8af0-4014e45d185mr12947493637.60.1795575880940;
        Tue, 24 Nov 2026 19:04:40 -0800 (PST)
Received: from BSDHENRYMA-PC1.localdomain ([43.132.141.6])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cde6cea7c38sm8091113a12.2.2026.11.24.19.04.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 19:04:39 -0800 (PST)
From: Henry Martin <bsdhenrymartin@gmail.com>
To: Matthew Wilcox <willy@infradead.org>,
	Jan Kara <jack@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>,
	Nhat Pham <nphamcs@gmail.com>,
	Johannes Weiner <hannes@cmpxchg.org>
Cc: linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	Henry Martin <bsdhenrymartin@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] mm: report all-zero cachestat for DAX mappings
Date: Wed, 25 Nov 2026 11:04:32 +0800
Message-ID: <20261125030432.274396-1-bsdhenrymartin@gmail.com>
X-Mailer: git-send-email 2.53.0
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

filemap_cachestat() treats every xarray value entry as a workingset
shadow.  On DAX mappings, value entries are DAX exceptional entries:
same value bit, different bit layout (flags in the low bits, pfn
above).  Decoded as a shadow, a DAX entry yields a bogus node id;
NODE_DATA() for it can be NULL, and lru_gen_test_recent() then
dereferences it:

  Oops: general protection fault
  RIP: 0010:lru_gen_test_recent+0xde/0x300
  Call Trace:
   workingset_test_recent
   filemap_cachestat
   __x64_sys_cachestat

Any writable file on a DAX mount triggers this once an mmap write
fault has populated entries.

DAX mappings have no page cache, so none of the cachestat fields
make sense for them.  Skip the xarray walk for them and report all
zeros, and document the behaviour in the syscall's kernel-doc.

This issue was discovered by Tencent CodeBuddy Security.
Cc: stable@vger.kernel.org
Fixes: cf264e1329fb ("cachestat: implement cachestat syscall")
Signed-off-by: Henry Martin <bsdhenrymartin@gmail.com>
---
Changes in v2:
- Return all zeros for DAX mappings instead of counting DAX entries as
  cached, per Jan Kara's suggestion (Nhat Pham agreed).  This also drops
  the dirty-accounting gap and the inaccurate PMD-order claim from v1.
- Document the DAX behaviour in the syscall's kernel-doc.

Link: https://lore.kernel.org/linux-mm/lh4cnpy2kw3tdtmhubwhhvim25kxpqxo6xttt7sihyx7x5hqdf@3tvivew2qh7m/ [Jan Kara]
Link: https://lore.kernel.org/linux-mm/CAKEwX=Py7W0vOwxKdWMCZu3d=BbF2OkgDt6Tu_AHhEJZ06w0ew@mail.gmail.com/ [Nhat Pham]
Link: https://sashiko.dev/#/patchset/20261123030014.3116755-1-bsdhenrymartin@gmail.com?part=1

 mm/filemap.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index a1b2ca5b933cb..4f6fd1f4caedb 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -4779,7 +4779,8 @@ static inline bool can_do_cachestat(struct file *f)
  * The `flags` argument is unused for now, but is included for future
  * extensibility. User should pass 0 (i.e no flag specified).
  *
- * Currently, hugetlbfs is not supported.
+ * Currently, hugetlbfs is not supported.  DAX mappings have no page
+ * cache, so cachestat() always reports all zeros for them.
  *
  * Because the status of a page can change after cachestat() checks it
  * but before it returns to the application, the returned values may
@@ -4824,7 +4825,10 @@ SYSCALL_DEFINE4(cachestat, unsigned int, fd,
 		csr.len == 0 ? ULONG_MAX : (csr.off + csr.len - 1) >> PAGE_SHIFT;
 	memset(&cs, 0, sizeof(struct cachestat));
 	mapping = fd_file(f)->f_mapping;
-	filemap_cachestat(mapping, first_index, last_index, &cs);
+
+	/* DAX mappings have no page cache; report all zeros. */
+	if (!dax_mapping(mapping))
+		filemap_cachestat(mapping, first_index, last_index, &cs);
 
 	if (copy_to_user(cstat, &cs, sizeof(struct cachestat)))
 		return -EFAULT;
-- 
2.53.0

