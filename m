Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.71
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793164398;
	b=RRJDzpKek5018FsZ1HNngZoqJAY4K7SW0qKN1WmaNd00wLk5v4lf1zKt3Dt6yP44Z2IX
	 LA3OkkXNw2CPXhwfoIiEnVsNQZThvMzBxPXovKhoaA6S48u8LSdgP0xz4Fz556bffPI8z
	 dNCPE8KtZARfpHC2666SbWb5lQ9Tq2+3AW+8312z6Iy/kBzY9wlTiRXTzIRxsCKB5BDKo
	 y7sHMf6QfcFd2ehXvGYFMgvbe0O8eRsn2lM14yuyJdyWjsNeiAX0ErFY1es0OzPpR9CGH
	 1nBvoQ7uAC6e3qDon00oZed7RyDlotBAm9dvsqC+QlC3hfQeprQe7ra0MzSE4/5RUKg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793164398;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:Mime-Version:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=jGHdCexy6WO9vn70fAdnEqZgjYrf6z9TvrrdavCztqo=;
	b=SbhyoUgWr3xyH9hD9ZkNJ6S7T05Ry0E044FoXlKr2eIAVrK9sTdLQMZN0rjfQyyAp5el
	 tEXNt1sWfVqmwZMybfQK1hj6v5mFQT1LWxAjsbJCWTqz92rAVu6Ym9yNAV2WIolnRZ4DJ
	 2m54vvARTVM5rgpQXsZ3LK3IQHa6JYKh32oH0mg7G+9nyVhVSj938lpIob4mFPxaY+KMF
	 xNNeAyTKOXcR089ULf/WHnzH/aN6QYKH0J+9EWkr5u2Bu1pp04mJ/rul0N+y4kNON29kO
	 Fc6Tak/ZqBBM4SPpgSR657pLgoEqVRcWuMgGYhi7J7JT+BCdu1z49GG9NRuW7+BEN1w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--surenb.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=hcYwNKo8;
	arc=none smtp.remote-ip=74.125.82.71
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B2A3606A327
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Oct 2026 05:13:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0B2A3606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=hcYwNKo8
Received: by mail-dl1-f71.google.com with SMTP id a92af1059eb24-1a2f2ea3c3cso951031c88.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Oct 2026 22:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793164397; x=1793769197; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=jGHdCexy6WO9vn70fAdnEqZgjYrf6z9TvrrdavCztqo=;
        b=hcYwNKo8138h0FpRdipjf3QUR1G+D6Npw4/bXwM9y1EWlTJ1AmtowA668MOfypgmiF
         Z9c/hVLG6Szdrj+YdwQZcg2wPQCR1iMVn2NUpuqryQ1rlzKZinM++QhrAbb1qdESEBWy
         NDRrWGMIbo22NUVz5IEh+R7A9LSbfRiw0tIkb7kWBTTbNP7cthcKHo5VIkjixOc3am1L
         9nXSCR41Q1B5l369TKOvEY+1WPOiJXLrjmOMj3fpOPrW/VnBz9p3mIWqF2aTswby175O
         NKWFrtb0rmBs5FVgx28uvyTYhTIpn9W1PpruQ+dekt8qYUZmaeTx30X7jjUC2zcuqyI+
         tC+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793164397; x=1793769197;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jGHdCexy6WO9vn70fAdnEqZgjYrf6z9TvrrdavCztqo=;
        b=GNSRn2KXZAxaEbGBztrS87/nvKCxKT/o/tH9ZgV/OVCbNazpBBJyybKtp69rfcI20L
         QsDI6WT09a9K7+6ituY6RSpXXr0MYIwmbEQJQUFEEzlUxBYdHa+ZHqu02BciUsqPKC6g
         rKYcsu78QTwVlHSWMuSyHmQ130iZsa72iPCcqLim8dHbCSuatlJKliIMlJJy1QA4XoTY
         bVKooMwDGaj4l3cZO4pQupPlgJogB5Al61XNavXv2LqZI8AfyCPGC05YkiORWv/nX3Xu
         hPTWjXOKaWUFE1kPZJL+H5uSmUxLxJjgEeqO1Nz51nzDbh1aRjV6IK5B0Nd9/tY6nHUz
         lycA==
X-Forwarded-Encrypted: i=1; AKwUvBxF7po7f91X4oxmz0T6vyKwCU+UlGNQvUPc0RCKXTrjB+fdcGFjYpQ0Lrjwd2dCE9tdQvKxdI33bv2wSTxt@vger.kernel.org
X-Gm-Message-State: AFq9FYKhSR1CN43jX+cr1NdSr1AdclcI3OiTwZJfZC1QslMIq3AbC14h
	LEMC5mv62KJ71I2TuNB07PsUb4RfaRQlWurJy/ym+avhkXAq82O67+mhQZFtG0uP0qFh/lI8e8L
	iNxcvpg==
X-Received: from dlbrl12.prod.google.com ([2002:a05:7022:f50c:b0:195:e16b:fdd2])
 (user=surenb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:126:b0:16a:c6f2:60c2
 with SMTP id a92af1059eb24-1a6cd498ddemr1946287c88.12.1793164396372; Tue, 27
 Oct 2026 22:13:16 -0700 (PDT)
Date: Tue, 27 Oct 2026 22:13:12 -0700
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.307.g5fe7bd680c-goog
Message-ID: <20261028051312.1505295-1-surenb@google.com>
Subject: [PATCH 1/1] selftests/proc: use RSS in /proc/pid/smaps_rollup tearing tests
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: david@kernel.org, ljs@kernel.org, jannh@google.com, liam@infradead.org, 
	willy@infradead.org, paulmck@kernel.org, pfalcato@suse.de, 
	usama.arif@linux.dev, vbabka@kernel.org, linux-fsdevel@vger.kernel.org, 
	yi1.lai@intel.com, oe-lkp@lists.linux.dev, lkp@intel.com, 
	linux-kernel@vger.kernel.org, Suren Baghdasaryan <surenb@google.com>
Content-Type: text/plain; charset="UTF-8"

Pss metrics can be affected by map count even if VMA tree stays unchanged,
therefore test checking VMA tree integrity can't use them. Use Rss instead
and pre-populate the VMAs so that Rss changes if a VMA gets skipped or
double-counted.

Fixes: ca5480fb53fa ("selftests/proc: add /proc/pid/smaps_rollup tearing tests")
Reported-by: kernel test robot <yi1.lai@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202610271934.fd287c3f-lkp@intel.com
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 tools/testing/selftests/proc/proc-maps-race.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/proc/proc-maps-race.c b/tools/testing/selftests/proc/proc-maps-race.c
index bf4c5073f6fc..b6d88afb252b 100644
--- a/tools/testing/selftests/proc/proc-maps-race.c
+++ b/tools/testing/selftests/proc/proc-maps-race.c
@@ -528,13 +528,10 @@ static bool compare_smaps_rollup(FIXTURE_DATA(proc_maps_race) *self,
 		struct smaps_rollup_stats *actual)
 {
 	/*
-	 * Clean/dirty metrics might change but Pss-related ones
-	 * should stay constant.
+	 * Clean/dirty metrics might change. Pss depends on map count and might
+	 * change as well. Rss should stay constant.
 	 */
-	if (cmp_smaps_rollup_stat(expected, actual, Pss) &&
-	    cmp_smaps_rollup_stat(expected, actual, Pss_Anon) &&
-	    cmp_smaps_rollup_stat(expected, actual, Pss_File) &&
-	    cmp_smaps_rollup_stat(expected, actual, Pss_Shmem))
+	if (cmp_smaps_rollup_stat(expected, actual, Rss))
 		return true;
 
 	print_smaps_rollup_stats("Expected stats:", self, expected);
@@ -759,7 +756,7 @@ FIXTURE_SETUP(proc_maps_race)
 
 		for (i = 0; i < mod_info->vma_count; i++) {
 			mod_info->child_mapped_addr[i] = mmap(NULL, self->page_size * 3, prot,
-					MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+					MAP_PRIVATE | MAP_ANONYMOUS | MAP_POPULATE, -1, 0);
 			ASSERT_NE(mod_info->child_mapped_addr[i], MAP_FAILED);
 			/* change protection in adjacent maps to prevent merging */
 			prot ^= PROT_WRITE;

base-commit: 39274b454e9993cea319f4ac342a8082a9ee1730
-- 
2.56.0.307.g5fe7bd680c-goog

