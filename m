Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C5323E1236
	for <linux-fsdevel@vger.kernel.org>; Wed, 24 Jun 2026 21:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782336596; cv=none; b=jTJOdsFl6msaFY3E30w9OLs399VOBiSUc4+bgj0JuzzBq1yTyLBNN+5+JHKLmTCyKimWqwbEn431g087XvAjLi3LYTYLjIzIefbDRr6mVETse5k49Rq0+AG+C37zACFuVkval4sIrkjEKlMCDbKVRYkKd9WwNT9qAMj0m4BX02g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782336596; c=relaxed/simple;
	bh=TuCF5sKw9UIxxPCRQm3DQ93sKxwz/gr8zeSeRiS6Tks=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=h4oIJjeJ9mBDRiW8nFQcw/j94QNgNvafimHVzri+vamZG1lK1UWRJ9XpVcPu21a8T044R/ss6nSzUtUtLc05S9ZmbXYr3+sf6CxGbjaXWD33/KAMSeXVXt/wQQxx0ZCBFSJ7Y3L/7tEsTRsJVBpeHIW72dacqV8bh1CZGzdObkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MtExybqi; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MtExybqi"
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-69dead44101so1371077eaf.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 Jun 2026 14:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782336594; x=1782941394; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cVkmaP5nSHlauDt7X0RCfjMJrLELIxh7onUnnYVHSNA=;
        b=MtExybqiA3sb98yJA7GExNcf8IcBhi6gHW87XmrRTCyJlSm7yat28V5rclkStvMtS+
         j2jLNq8aLFYvgvsEvV0lSwAi4L20aWrJM3bbj7dPbaZnW7LyBclHPSUY0ILR8nKyJLw7
         dGYMKIqZpt4OLOT1oWX1jOz1X+UJUUEXXCTVkbqC+Bp8FcNqLQ9veKm9sHEScMXlhS1P
         bl+0J1SC8hrY4oyte4cFVONiGqg1XLqh0/7hLNwej/VAegvqK3SyqxVkZ02RGbY8z2Hp
         hm7xDAbHHQLtrRavDgAs17vO7EozRaKhyPmmb1eU/NXZ92QvLOgXFqqgg+w798kyvtT9
         43nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782336594; x=1782941394;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cVkmaP5nSHlauDt7X0RCfjMJrLELIxh7onUnnYVHSNA=;
        b=V0LQbdBO7ePbR/sjMrURTTO0GRuO8ekvxykXYMLdyxMniB+6wpy7VAY10dZn7bcPZR
         KUbN+9TkdnoHdkas+JXLGLqH7LjASWmMmjNLfn/njUjG/fXGATDyuFQmTWlQpyS7S+a6
         scYr6JxphHgT+0WYZYJhAb7sV+ultmYRLVmEKK1IJaIGvfh0+nvbE5qCqjccU9B7Qc4v
         ouQCX9iuRXAf7Xr6LkakcRrLNrQLTKylZw8SHe6mabG4IhcTcRU0bhmRMEPse3xmnID9
         jn09DI5Eq6lDMYyI/I7FBrGZEHwETh41zKmhfGs7rFpOBhFf9K88MpbpUd1FTKi+7S7y
         Ioiw==
X-Forwarded-Encrypted: i=1; AFNElJ9j1kzhEaRet/7jNQ4Z3ZV5SR9my2ho4JYYrYncwjOw6uAv44cj/1k8GYY/Wu5cv6AzxgWOAxD1L0uaRSf5@vger.kernel.org
X-Gm-Message-State: AOJu0YyoDBXCrE9+CBAVTaHr6yA6omMNNHq3+nItdv3fWwTo9aY69PJo
	r/kp0a+eNJ6erWCRtsV8BOnqN0/tlgCVhsH1ILvWUiVWKH60ZC0uceUFP2/7gw==
X-Gm-Gg: AfdE7cnDW7lLfUMKQyVm6TyK4bDmD895PlMOgU+wiSdDso6VnpNBwUiEDz9gwy+VLyU
	wn3EPdrzKatdzYZc2RMfVZ+DQSXl2DUqrPiL8LBFG5v92DPVK0B9qUjNjS5H7GzJZjgvV8JFmag
	N/WXWB0vHyL9mW/umUByWNn98IMDfUh5tGTBo9glzmFSRsp0bYKDgM8rso3rVjsHUJpMa/ZG9TH
	7nddC+1sTW8xiiZoWmfFlPraSCvX3Km1b8cRHsvO4lDQBCwwTuo4FCO6HCa30u9EAQrVzv/NU3B
	oZS/h3EvVyiYCJcdlrWLBsv2+wys9JrJVH+er/anR8aOWcdE5ZdjcE5TfZN0LyHJdK+QbROSj0O
	sjvO6wL4P6fMSZ3PhFjTuLk03wokLE1BMRD/9sM7KZnMsc5waNifu4EudvzipGgJaS908ZFBt+n
	5yjVCdsxVJTuU4U2OZpoz2cyEGQkQ+p86E3NhmjLkaVrbT0U6Esek1pP9uQldyvped
X-Received: by 2002:a05:6820:4b14:b0:69e:ba22:33a8 with SMTP id 006d021491bc7-6a122e90ea3mr3488526eaf.9.1782336594077;
        Wed, 24 Jun 2026 14:29:54 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:57::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4472eccfa68sm10448851fac.5.2026.06.24.14.29.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 14:29:53 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: brauner@kernel.org
Cc: willy@infradead.org,
	hch@lst.de,
	djwong@kernel.org,
	miklos@szeredi.hu,
	linux-fsdevel@vger.kernel.org,
	fuse-devel@lists.linux.dev
Subject: [PATCH v2 0/2] iomap: add helper to keep uptodate bitmap in sync
Date: Wed, 24 Jun 2026 14:29:23 -0700
Message-ID: <20260624212925.1668662-1-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series is on top of the main linux tree [1] because it depends on some
fuse changes in Miklos's tree that were merged into 7.2 but not yet pulled
into Christian's vfs tree.

The first patch in this series adds a helper to iomap that also updates the
uptodate bitmap whenever a folio needs to be marked uptodate.

This is so that external callers who need to mark a folio as uptodate from a
non-iomap path can do so and keep the bitmap in sync.

The second patch adds the fuse caller side of it. fuse uses this helper in the
notify store path for storing server-pushed data into the page cache pages and
in the writethrough path when a full folio is copied to the page cache. This
series is needed before fuse can start using large folios [2].

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/
[2] https://lore.kernel.org/fuse-devel/20260624012132.1719941-1-joannelkoong@gmail.com/

Changelog
---------
v1: https://lore.kernel.org/linux-fsdevel/20260623202843.2064992-1-joannelkoong@gmail.com/
v1 -> v2:
* drop helper for clearing uptodate state, as per Matthew and Christoph's
  comments

Joanne Koong (2):
  iomap: add helper to mark folio uptodate
  fuse: use iomap helper to mark folio uptodate

 fs/fuse/file.c         | 2 +-
 fs/fuse/notify.c       | 4 +++-
 fs/iomap/buffered-io.c | 6 ++++++
 include/linux/iomap.h  | 1 +
 4 files changed, 11 insertions(+), 2 deletions(-)

-- 
2.52.0

