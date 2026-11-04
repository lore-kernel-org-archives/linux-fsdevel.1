Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793751553;
	b=J/9cDPy70uaQC0Xs8iiOmsIdJO27tRe8xzAVURMjqHsY6stf28nzUmoXaHFgRnN9qOii
	 1OUfXFud85IGtRnwmIAOSHPjAkRSBSEo0crJm6jT0OyQ71W/XOrUOq+DMTdHTC6IOnxyD
	 VSNw8V4DLlQv/cYisUgB+iZiiqZBI++8JZkWEtRDo1VZDGg3M7XXsRwdAZXlixjtrhwuK
	 Or9lSGumZTqdj4indb5lW6wq93z8aUXHkBZbu0/B6RJBiv8bZbikCQ9udDZh5c4LL9s/k
	 pkyM99BBzLmNvjUGkCPs0FaDzDN6mrGuPqYmtgtnJ9DACVm06CCpurqzeQzzIoDWKYg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793751553;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=xkQ2a4rr4OfVHQ6kuJzVvVdC31NeQtZjjZjX0zJeTWI=;
	b=O5JdYyRqHnG60VHSYXC9svYpG0BNuyBMaXGuMxLQjWQWL0k8FqmI2+vu7+5QHXAcQAl1
	 goSrWjlMtV5hzM8na2W7LrJBD0h6GplRxMO+r+tp2AxKjt4AoUi9FropLhPW/fBXTH4Cm
	 jIGAskBioB5smLYk0tNuc1HppLOa8pAcooA6yrDlPW3NLwGHmF6dCCIgZTZB99HQ8puIh
	 3Y/IndqNJCP4FQIryp5iMUTSYUy4n5XgDBinq7Vkv4VjNcebDe7F/P8q31gvwjitMOg9d
	 u6gzDJR6ZKKnthqVbujoWBlb2ms7oh7MfUVyLL74Jpa1mLcTEErVzsD4OZL63npR9pg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nua3l3Lz;
	arc=none smtp.remote-ip=209.85.128.54
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F142606A31B
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Nov 2026 00:19:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4F142606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nua3l3Lz
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4a5720b0a57so7885825e9.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Nov 2026 16:19:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793751552; x=1794356352; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=xkQ2a4rr4OfVHQ6kuJzVvVdC31NeQtZjjZjX0zJeTWI=;
        b=nua3l3LzXH5sC9A6SJ9iKsthhz+gzmmes08RfX+Km6fub4LXy2WKga81YLv/KZCWh8
         aXCZIIS81A56KCQkdxYaQNk5KHgirFO47zSnsfkrTpI8Z2AFJ47Q48Yw6MG+mXUKNu9J
         7EYoJk7ILdJjyCu6Aejpdt5y38qkkDrNjk4xAeA3yIuYCixIdbBtd+K62+4bta72poy4
         GWeWprgrZ9BdD55agKUAF1VFYRsPQrgK703f6xRrYn6zCVxoijW2mmd95cLOAZyFHT7F
         WT9RigCUK7rGvk9in63j78CQ5ytxfWfGFNCbaMfe6VQIjtgNRpE7kyEJsYjkXjeukJ30
         Lm2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793751552; x=1794356352;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xkQ2a4rr4OfVHQ6kuJzVvVdC31NeQtZjjZjX0zJeTWI=;
        b=I7MXrFT0zhjTOJE0JWg9C4CSrZpZXb7s0n58pCMrM0NODZ32vXCCnJOYfduniHPMyD
         W8dMjuNPs31DdmeMTPIAyHq6RmLPMvBnuzIJGqpCVPGwfvzu8H5RKzx/qGM14EvZ1heV
         +tAeVQ+7VZ5W9cjLLmtRoqrBG7UJYWHGkLvYY369gnhxuqeroBmhsVV4NBRjbEdvkPx+
         Hdk26AVgRo6FYUSeIQm5b9vxGEHLv5ffWz47jeqcmruTDeTq2EvrXTKafNbONTvOmiKg
         GuEaJrIyL5S1bnmoxgD6Dgm5aqg5gztmY7lqmF8Sa4OhFGli79ahfcY+NS9XDgRJuH98
         vsrQ==
X-Forwarded-Encrypted: i=1; AKwUvBxzn5fef5Uy+wZrbmT0xuUJ1tyyE/19aFSQfHdbtJa39ZVV2+l6EPixbYdwQfohWY1YqObwqeMqT6uai7Md@vger.kernel.org
X-Gm-Message-State: APuU4Z8INootAYktm/hIpvOfvBIP1EikPaTCr9Pj9SqM7+Xj87KEzvIf
	Mggp7WVoULflkcAp8k6wbe/oBRhEYQLrXtEWqGGBnwWw3wFzraKvEbdm
X-Gm-Gg: AYBFou0v7diq0Bq5k9XNYFfDQDmGlHaiHivUL1fb2pRsG9J36vRbozJV0kY2PyYXqe2
	Wc6J07qBNMyhVKVu5eWwz4paxO0gUOJAi84fc0WHbwhI+eAhuUne2M5lQc7M6A5v/z1cBjUq8BX
	A3VkAabXWXoMvVgq5xCo6eBNhwoiJSBCGESYOgppP5QnFaYZCnk93mBPyWmdxs06dd/W1fEFyWc
	yWF4hg60aEGhHWnUqRWFLySnYlM4pPaXDqZWnZtF91NYYLGwCnUU7uGqmJg0alLzla5yyIPuZda
	EI3wquKG8GmXWEoF2rwr3+8WQRt2QeJpyFQInQIMSBaz0GgshyRDbNqFuKlKz/BExZGUSkUv3mO
	3EBZQsrZXbzw0Q3FwnTmgCVTv/jGxnNtiFN+viLZGXNrmYNHW2y2kVBAlPpto4D4SmnSObfGxlv
	PPObOlx46LRd3j/iDHU+2QbxGW5toBeFX3Ys1GewPIA/CH0VwEGEfjSMoZe2xZyVHCD2gvN4heb
	vHKJWm4IlHu3XbussfpInJ3oCCs2IcgM6/dbph8wSmBK19Z9M3wUfQMVhHSMHliZvKJyhBmdAqy
	1YP7HPCJpkzsVfkXvryyIN4cbeTZ0RWnsPWfALUg6PQ0mO6DOU+jK+ZJZ55mlAUoFtm1IcxL9eL
	U3tIsxFNABeRDGpqL800yAHdJy+nWB6dU
X-Received: by 2002:a05:6000:3101:b0:48f:bbb5:61c2 with SMTP id ffacd0b85a97d-48fbbb563a3mr6701949f8f.4.1793751551597;
        Tue, 03 Nov 2026 16:19:11 -0800 (PST)
Received: from 127.mynet ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48feda1fb0esm676676f8f.49.2026.11.03.16.19.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 16:19:09 -0800 (PST)
From: Pavel Begunkov <asml.silence@gmail.com>
To: linux-block@vger.kernel.org,
	io-uring@vger.kernel.org
Cc: Sumit Semwal <sumit.semwal@linaro.org>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Philipp Stanner <phasta@kernel.org>,
	linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org,
	Pavel Begunkov <asml.silence@gmail.com>,
	Jens Axboe <axboe@kernel.dk>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	Nitesh Shetty <nj.shetty@samsung.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Anuj Gupta <anuj20.g@samsung.com>
Subject: [PATCH 0/5] allow dma-buf-io ctx reuse across files
Date: Wed,  4 Nov 2026 00:18:56 +0000
Message-ID: <cover.1793751001.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.54.0
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

Currently, dma-buf maps can only be used by the file they were
registered with. This means that we can't open a new file, even if it
comes from the same subsystem and point to the same block device and
use it with an old dma-buf registration. That would be too restrictive
for upcoming filsystem support, so lift it now and allow reusing
contexts between files pointing to the same NVMe, even if they refer
to different partitions.

To do that, we add a tag representing for each file, save it from
the file passed during registration and use it to reject files
which tags don't match it. Tags are set by subsystems creating
files, should be unique and represent the instance of the
subsystem.

Pavel Begunkov (5):
  dma-buf-io: add tags for sharing ctx b/w files
  block: set dma-buf-io tag to block files
  io_uring: add data to dma-buf convertion helpers
  io_uring/dma-buf: switch to tag file filtering
  io_uring/dma-buf: get rid of struct io_buf_dma

 block/fops.c                 |  1 +
 drivers/dma-buf/dma-buf-io.c |  3 +++
 include/linux/dma-buf-io.h   | 22 ++++++++++++++++++++++
 include/linux/fs.h           |  6 ++++++
 io_uring/dma-buf.c           | 19 +++++--------------
 io_uring/dma-buf.h           | 24 ++++++++++++++----------
 6 files changed, 51 insertions(+), 24 deletions(-)

-- 
2.54.0

