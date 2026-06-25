Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 402AD40D595
	for <linux-fsdevel@vger.kernel.org>; Thu, 25 Jun 2026 08:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782376660; cv=none; b=Dl9irRy+l2adK4sW+kzBneFJaHR/FHiV3SPdL7Gw+V6YKhHFCjM7fgav4bpBFNZwtQT7THR6H1mHCZ9S1NIa71QwqiBPH4KfdX9v/WTidZrFFjqj93dXyBKmzVVuNIjuMac7Fw+RZFFMsmLVwg1oShOk7GvX/YFnJFo/MaxVY0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782376660; c=relaxed/simple;
	bh=D+2EqPDkxiIP7659jXJBe6+HwYhGEbOa5dHouxpNOHk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RjMCFtH9sVbC1A4N3kxp/TKcGkrzFugDZazmbOf18vaxjY97MQl52+cY50ZjBBBhgAfg3z8Fszjda7rSSNuRtw1qxuGJviCpDKfUoFZZiPAtpX6b3XBlBxC33NKAsL1luQx5uRzPSmTaR4p4xrP25Pdcz91AcgvR/+i9Lmjjv28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FiV0d9If; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FiV0d9If"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-4629d80fa08so1811074f8f.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 Jun 2026 01:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782376656; x=1782981456; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0J1jnzmQVNhnRjMNcripM0zyo9VQmhoRd3tOhETxEs8=;
        b=FiV0d9IfxleAJlGEoGlvmiMkRrULIYR8hhuIdDMze2XplYzVJt3F+WrT6jZs5TDmxp
         Jmz1uLTL6mtALma8rWFD/U19FLqHTNkuWqP+acUqEK5YSten6qMKZ/OXBfqIX9k3+PBl
         1lKXyzDWFGJ8/wez3NxDniWLWIevdIsoRIz4uxopkhwzt5leYD5T9tPQQRhu7GUc8CQK
         nHoECrfsBbnM1/WV1hQY9xloL7Xb7DSDCtv87YpCTnMw/970CvHgvQ2w93mHddmlK2Yb
         JQqCwSd6JkwP5TuA5b5bBDSIG2BQFg7Yl1AzxXIrWAxzN27GRxzNBntEdXG7D0kO+X46
         JBDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782376656; x=1782981456;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0J1jnzmQVNhnRjMNcripM0zyo9VQmhoRd3tOhETxEs8=;
        b=e+0PGlFbcJllvYHcuUYIYtGLoCmZJAy4zgfFp4TJydR/VWt+riqW1+pYU8Nh/nm9ou
         fgsye8CQXf+XZuYdI2O8pMThGpBGUu9oaqkR36G/sHVkuFx6+VYQUOCfzgqBNse4v1Dr
         kQIMzwiXYcTGdRApwgZAXmwxY9EKHKx7r4ciigzdjzORUYgEQD8nlP0SYpzbSMXQcqsk
         kVAqKfs69WEsKaB/V1Rgd/To4gYEpB+3ZYkqYajJbdvpT4dnklNrhn/bH/FIDQnyEBfM
         illeF+e+b0A604NB3mMwuwFj5LoIJdWo97Ry8Q57TWG0wjWZqLJ9AP5gyoW9VMaECSPm
         O7Kg==
X-Gm-Message-State: AOJu0YyNcpCbn9+VqpFzsyeGPYYIo10bTfi4XjW+kDZ4w7QTlJ+G/z4H
	ixImoQ26lJKMbbXdko5jxSVA9K1IGeuCeXdmSnWk/0kSwVy/MbnVoKejeA5cNPzofB8=
X-Gm-Gg: AfdE7cl0q/z+n49k3UAkemB7G4TaTA/VjaFypGlwD2c92oe5BBCG7e9V3XOXuFb5Ovw
	fZfGhX/HdzUpLxfAMH379qnFbhA7ZW19Lz0yb/uV7svAzkIWnVlo6GxmVTdYhn7atrH5C9vsqFm
	VSHSFb1I4w77V9eEarYJBaBwYsjj4RtQhIR0geV4j+AYwI4pbN+JYG7+vx5n1OVDakbwUVlXE4f
	c3FDJoZM3U8qiUzZrGSHOsmjkasYr1+Wu+Dx2aZdnIFMq0J2Fa4y13+rj8I8tmyz6hEbwOo6euF
	OGpGwiRNOhtX4I2PlxTpVYMttb+6f8LW2t7xAEQH9FQqU4ioBoYn///nBjx46bfry2vsvfUcPBn
	p8kWkoO5RUCIsHoyL87tge/97roO5Ofb0g6IoFnSfbIdcfhbXl7ob9LHv2aHXEWYkJRKEk81WuH
	PZFGRDeCuKV8A7JoaigwM=
X-Received: by 2002:a05:6000:2485:b0:46c:a463:987b with SMTP id ffacd0b85a97d-46dc1e82faamr2365468f8f.41.1782376655597;
        Thu, 25 Jun 2026 01:37:35 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-46c9ed7491esm9943798f8f.37.2026.06.25.01.37.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jun 2026 01:37:35 -0700 (PDT)
From: Askar Safin <safinaskar@gmail.com>
To: linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-api@vger.kernel.org,
	netdev@vger.kernel.org,
	fuse-devel@lists.linux.dev,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Matthew Wilcox <willy@infradead.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@infradead.org>,
	David Howells <dhowells@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Pedro Falcato <pfalcato@suse.de>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Andy Lutomirski <luto@amacapital.net>,
	Collin Funk <collin.funk1@gmail.com>,
	David Laight <david.laight.linux@gmail.com>,
	Stefan Metzmacher <metze@samba.org>,
	The 8472 <kernel@infinite-source.de>,
	Willy Tarreau <w@1wt.eu>,
	Joanne Koong <joannelkoong@gmail.com>,
	Val Packett <val@packett.cool>,
	Andrei Vagin <avagin@gmail.com>,
	patches@lists.linux.dev
Subject: [PATCH v2 7/7] pipe: set FMODE_NOWAIT for named FIFOs
Date: Thu, 25 Jun 2026 08:34:09 +0000
Message-ID: <20260625083409.3769242-8-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260625083409.3769242-1-safinaskar@gmail.com>
References: <20260625083409.3769242-1-safinaskar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

CRIU relies on ability to do vmsplice(SPLICE_F_NONBLOCK) on named FIFOs.

Signed-off-by: Askar Safin <safinaskar@gmail.com>
---
 fs/pipe.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/pipe.c b/fs/pipe.c
index c0ccf21b9..a8e9b4459 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -1156,6 +1156,12 @@ static int fifo_open(struct inode *inode, struct file *filp)
 	/* We can only do regular read/write on fifos */
 	stream_open(inode, filp);
 
+	/*
+	 * CRIU relies on ability to do vmsplice(SPLICE_F_NONBLOCK)
+	 * on named FIFOs.
+	 */
+	filp->f_mode |= FMODE_NOWAIT;
+
 	switch (filp->f_mode & (FMODE_READ | FMODE_WRITE)) {
 	case FMODE_READ:
 	/*
-- 
2.47.3

