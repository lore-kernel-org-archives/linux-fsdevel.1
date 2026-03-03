Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19EAC3537FA
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Mar 2026 23:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772580940; cv=none; b=WeEHyF6Vltnwqq7vusEHXl7pKlmQ4e8NlD4ClpFaUkeLFa+nrNODRxN7k+hiKGqtCAXMOODrpWJoDfQG4OI/fHUPb4vzRMFBi4WzdZJmNHtzipBADmPbZj9eipD3I1+JjKyXhI4TBb7CsCKJJrXJQrPgh8ysZN370iljWxCwidc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772580940; c=relaxed/simple;
	bh=dCUHP9CgxLTwhE4ZO5/pmfP/TWGqsXqdgVyysbY1DjA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rmtKs1anU7mrDkJ/6LRK+Tgth654PJgo/+PXLhzVZGXUf5MNj3wxTtPJ7Cwu9bq5SXwvXgRAsLTZE45SnM1LQsN2aMx46bg6ae2m9oau0dFtRjBwSax2Am7H9Yw939W3QMKwWnQgy0YdapDrgZVQASW5KYw14hzwI00AabNBhPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UOYk0Z2l; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UOYk0Z2l"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-8296d553142so97280b3a.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Mar 2026 15:35:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772580938; x=1773185738; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DKbVmY+efMopyqBXD9I1gQXiaAK8vG67nYLTMzqm3vI=;
        b=UOYk0Z2ltgbYwdoHNyn1UDKz/r7Uw3B5bdoFmnyOFuZnQG0CtRk5a2xeDCxSAgXydr
         bCKBI3aaQKfsPvMNg9V6b7nJceoux1nJvYRjdvI2WI6bULtbGLoDxIvQagHsXHwdvYWW
         PYx7emUpgUjPoetOoP7O3xKMtT+d6eHLAacJ74LxjyC2VgYdhUmH1sVK54Dio4XKg6rm
         lAD+cZ/eBTdBAT6Gg60ss319+lGTMP59aB6qJ5bQ4AbX9Q70sNZXjL5LaJkcuyf+b97v
         M7sQylkmP00H8zknacufpwITKZwhsWyR8/H5cAPVrQ++vBbdJjBOFOR9xs8M9DkuJ5dK
         wI0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772580938; x=1773185738;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DKbVmY+efMopyqBXD9I1gQXiaAK8vG67nYLTMzqm3vI=;
        b=UiPuPq/YTQGEySJZCuAsPPoY4HHJLb8dn6IsJHYln/dXIbDYTaSCrUtcAX5XmRuiX5
         rRD4Wih0Zn+WnIDzmyHYTpERLzvt96CLGKQSWC1MHwNYeMhlhbx0p8YtZ7vFMVj5SoFn
         2yLSkxlRL8w8o9awGw8AahqqeX7FGO0ytKKkbI3+5PJIg5KtrXm5k3Btlc7EltjMny+8
         wPL5uLoShtibcir/NtgAnuNb6y9bym176pE826QXzbUOlI6RB9Vhg4IRUE6GqI/pLgiP
         aejx9NgxTcwlg85oyOzPxWm2Pa0iO8ibwlF+3Y9iEnpfVDJ5p5DGwZzSNazq2ZvVBoT/
         oYlw==
X-Forwarded-Encrypted: i=1; AJvYcCUShT36Taj5VVuF22O/1lwbApAmMA94HKK41eAw6evfKkOkY2pHcGUzcNSh9Vl3TpoHArQ3CrOTOgS5YapT@vger.kernel.org
X-Gm-Message-State: AOJu0Yxqy5diMsvYvg4GrZ2DQUIiMfoiyXjshipM5H2JS4jRrSfLgf5i
	awMuJMV6Dk4gSZgKEnwTpYFOCKympBNohZd2QSq+dLCConQWMikjoYUy
X-Gm-Gg: ATEYQzx0isna12a8X3coVkpxDm7Cuq1U+m5Kr2ElHdLZbJ0WbqhM4EpxYiwWT9Fc8jp
	WMiAgp1ch4K9XkhVbwDcLascfVVz3U2rJAI3x9tdLyVHB0epP2/G8UmBnlmKKsNjHKdnLVyx1lW
	sH4qNsVGLjktml23wUg+eQ6IvxYwtKLTFYqjEIPsDKdpyeP7Gph6bSpo0YyeX3560laqkpQQWjw
	8rrX0iNLgacxmywDy7T4KmUxhKWFWFAJRHwrJV8v4wxuiRuP7bv8HPuZpbCxLKmvdZOvr6sqzij
	w+DaI/okrnBBTGj58oYCr7P+zFNNaJySky21WvlAt/TMbWUFKgocYYCXSfw0CIXT23vIIubQLid
	3jgvX9aReLj48wZjNOUx/sAdfR+JIN1xgn9KuhOX1FQgO/vQt3MxIeyJuI42bwFFFY19Jxd/M9v
	ZUIwK9iBVAHb+V5YJmdw==
X-Received: by 2002:a05:6a00:e0a:b0:824:a8f2:7de7 with SMTP id d2e1a72fcca58-8274da219acmr15477490b3a.60.1772580938385;
        Tue, 03 Mar 2026 15:35:38 -0800 (PST)
Received: from localhost ([2a03:2880:ff:59::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82739ff350asm16087111b3a.35.2026.03.03.15.35.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 15:35:38 -0800 (PST)
From: Joanne Koong <joannelkoong@gmail.com>
To: brauner@kernel.org
Cc: djwong@kernel.org,
	hch@infradead.org,
	willy@infradead.org,
	wegao@suse.com,
	sashal@kernel.org,
	stable@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 0/1] iomap: don't mark folio uptodate if read IO has bytes pending 
Date: Tue,  3 Mar 2026 15:34:19 -0800
Message-ID: <20260303233420.874231-1-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is a fix for this scenario:

->read_folio() gets called on a folio size that is 16k while the file is 4k:
  a) ifs->read_bytes_pending gets initialized to 16k
  b) ->read_folio_range() is called for the 4k read
  c) the 4k read succeeds, ifs->read_bytes_pending is now 12k and the
0 to 4k range is marked uptodate
  d) the post-eof blocks are zeroed and marked uptodate in the call to
iomap_set_range_uptodate()
  e) iomap_set_range_uptodate() sees all the ranges are marked
uptodate and it marks the folio uptodate
  f) iomap_read_end() gets called to subtract the 12k from
ifs->read_bytes_pending. it too sees all the ranges are marked
uptodate and marks the folio uptodate using XOR
  g) the XOR call clears the uptodate flag on the folio

The same situation can occur if the last range read for the folio is done as
an inline read and all the previous ranges have already completed by the time
the inline read completes.

For more context, the full discussion can be found in [1]. There was a
discussion about alternative approaches in that thread, but they had more
complications.

There is another discussion in v1 [2] about consolidating the read paths.
Until that is resolved, this patch fixes the issue.

Thanks,
Joanne

[1] https://lore.kernel.org/linux-fsdevel/CAJnrk1Z9za5w4FoJqTGx50zR2haHHaoot1KJViQyEHJQq4=34w@mail.gmail.com/#t
[2] https://lore.kernel.org/linux-fsdevel/20260219003911.344478-1-joannelkoong@gmail.com/T/#u

Changelog
---------
v1: https://lore.kernel.org/linux-fsdevel/20260219003911.344478-1-joannelkoong@gmail.com/T/#u
Changes made to v1:
* Add Darrick's reviewed-by, cc stable@, add link to discussion to commit
  message (Darrick)

Joanne Koong (1):
  iomap: don't mark folio uptodate if read IO has bytes pending

 fs/iomap/buffered-io.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

-- 
2.47.3

