Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793892055;
	b=d+IYHIYtVdF7ZvFbwD6dwuXXgbQs22c8PgvU/64vgxMJLzYOIOAHBLt1JpWr7jcLAkjB
	 jkaQR3wRd4iagW/nzBl0z7q9lMHgf3GB+qV88a/Esbv180H+17WCTD4neuHp5wJy2JQ+x
	 QBpjdSW++p5V7pkChbWmw/+8M/TLy+lMjI2yH8bHe40frn1eltSyYrBlh0E7QVrAuH9aF
	 aZkNiNu89wyirgiVHqc/xmVyuKsub/3Ib1xJr0u4VIeqM7ZdxyPWpKKF+5+5Fa9xlnJ97
	 d25hByrxj9XuDzNjsugXnL6w7XI4BwolEn4NM95FUnr9NWT5Ykn427N/hUa6IZzSmPA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793892055;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=g7OooAgXVyrp/xMdwbWWynIIIxWieLjdlc+2il+3n9U=;
	b=TkAeNPMrSupFUlJrckIei50nIel0DHSmmqHVUb2YWM8av6Q/cRbXKWpdyfaLoM9ueNxe
	 ioN/c9Twnlbr7AiUX7OIYnezNIy3172pZs6XNSVqvSU3m6K7K1BQdxrPykhCQnQsuzh+h
	 Dy+IdbIxoEu1OD9yp9RATSDdEPv10Uj98e5ILjN/V1Q/11zLWmbuSAh7CBkwQqOEXhraH
	 k75yMxHPGpjGESDl1kNvVND2U1hSt6uDfV5TkQ5GRCmgk4P9eYQ4UxpEQrzOoj/azF3u8
	 n3/gfCgbPeo/KbywLi52JTsCnn1TJpDzJEG/u7Uc/JdFwptTOhe5pqX2UlHCfx9Xbww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=adYbJztv;
	arc=none smtp.remote-ip=209.85.219.44
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C7AE606EE91
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Nov 2026 15:20:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9C7AE606EE91
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=adYbJztv
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-91ea2e29d90so2500396d6.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Nov 2026 07:20:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1793892054; x=1794496854; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=g7OooAgXVyrp/xMdwbWWynIIIxWieLjdlc+2il+3n9U=;
        b=adYbJztv1KkpNtEqZot0xRjgVbMuObrkgEOc4jvRIE0WqspU1MFLYYVPGTqjzSSmSC
         TwBD6eggaI9ZU7TCa3LUrInT2iKrhkaSqN2HBIktdfnPuJ/ZuL0zsjqKAXI9r3NxJD4k
         8VfMRUM/MTTG1Yuds15Z9y2RlMyEp1Qjp4QJz1dp+GMrkQ9JyKUNTN2DwWH2SDlTHZI0
         aJnK/rqIJwfeCpIjL/9gDcBStHKvA7i9ElTVPOQdtxxxrf8A7+XrhFtOAhMPYyWSsHNd
         Olw6Pqn35nzl6d940GZs2++t4fIv3MQaZ5lwpLYOzusbWLrIc/dO7GKBaY7cZK5dPpMi
         hpBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793892054; x=1794496854;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=g7OooAgXVyrp/xMdwbWWynIIIxWieLjdlc+2il+3n9U=;
        b=y/xwkKYgN5Zs2vr9TbW6r9aMb8JkDEb4ARttzvce0AjuQdvRfGqgACQFFmqvwLgyI3
         BVKpJKT7Q+6QNgF8BXhGBFSAb40wbesyMbsTbFz+3itRcV4HCZ5zv8SCiDEFIkZjs1Ij
         mgMDFklXivrBq1f/Cu0OqhFJAGOtOpPRfOs92YkeGzqvHTNukx+0BHX8uMNSRth+l0zU
         TUIPDxFoy/DaWlFGq3leB9gANxptQ4nUfLNi7WX/uG3ygeBjkfowBB79iRrVcdpFKs2o
         zs/k6RtRVsTZY6aCciRgz9ECqIoxg9J6F8ehgaoete+fUEeTZvSaT3NqFBVnFheAqrY2
         7sfg==
X-Gm-Message-State: APuU4Z/vBmq6Frogos9qMv6D6EdgmSq7b0L+Nmc6NKgkrG4LqmV2g3ba
	8KPHnOyHL2McFKlRk8n6vSs2R+lr0+jpTOQmuE2yG/rFAZS73FneQwZR8xmBN4ZDW3s=
X-Gm-Gg: AYBFou3ydtoebxdUYkOwaZO3F927wGBCajqi3ywrWzh+Tm/WJj4j8w0I+b/airhDKeA
	SxtPMS8uKA0zHTTxxCo8rP7vEuPZlbRFC/fCy+ZH03btO1NzlZ0TFoVjyM00TP74USiAnhcdwIb
	RWedFO7wJUqR1dcKAv9wD7PwboYTuv5fftc6uxcu0fhT/Sy2Io4pMLjMO3toGozH6auC0Ubg6gS
	qQtKzyPZ3bhfS1ionKz+3vhCUEtD7gTwYCbOX/56x6LF/jrp//euV/ptD4B+UEMe9ld5nTajljh
	6A0zEI22DYh6LhuEwySWcyO1pt4mtqOQyq1dpq6vBAhlagVjEaOGCUMXKggFik1f4sWYEp363ry
	1U+pFLlY/W1bBfYgzK1a8A1Q3rtZHaPh6A3GjpNEgNCP63qHxXpIpU7J4IYVWBZSw1+4sXdncss
	xpoxWlT0YHnxBkdnGc1HYDZjd10suZXdVuh8bHwP5Ky6+c+o+wM4a+B3hLX8OJj75RpRH8YjShk
	ocR2YsRVXdH8x2Tr/NIpEmYq4Ie1s8oNLCVvGKkWkMM48sjJrAdj4EkMj7FQJIBJahcBCoidy8s
	MzNPUQ6SgQZMbQWeCD3g5qEdDQ9OHWYVxbENVEsbMGlG
X-Received: by 2002:a05:620a:4592:b0:93e:6618:f4a5 with SMTP id af79cd13be357-945e158cc18mr466781385a.3.1793892053536;
        Thu, 05 Nov 2026 07:20:53 -0800 (PST)
Received: from toxicpanda.com ([153.61.196.244])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-945d4844be4sm485076885a.29.2026.11.05.07.20.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 07:20:50 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
Date: Thu, 05 Nov 2026 15:02:48 +0000
Subject: [PATCH RFC v3 56/90] cgroup: let a cell make cgroups below its
 budget
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
Message-Id: <20261105-b4-cells-v3-56-bc9095937a84@toxicpanda.com>
References: <20261105-b4-cells-v3-0-bc9095937a84@toxicpanda.com>
In-Reply-To: <20261105-b4-cells-v3-0-bc9095937a84@toxicpanda.com>
To: Christian Brauner <brauner@kernel.org>, 
 James Bottomley <James.Bottomley@HansenPartnership.com>, 
 Andrew Halaney <andrew@amutable.com>, Jeremy Bingham <jbingham@gmail.com>, 
 Tahera Fahimi <taherafahimi@linux.microsoft.com>, 
 Serge Hallyn <sergeh@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1793890934; l=2016;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=OTJ9QCzjA253vmOiFzdmdl9ASZAcRIOzDg5HpZYKTB4=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QIre0SmzA0yI/wJIyenH7ASDQ6yQ+AQo9cPfV8U2dBwxSpmbilBW5yHo+V0cJmVO98novDGWWSU
 Iorhwf+EV6As=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

An init that manages cgroups moves itself out of the root of its
hierarchy, enables controllers there, and creates one cgroup per service.
In a cell with a block of ids this fails at the first mkdir, with
EOVERFLOW. cgroupfs is a filesystem of the host, so it cannot hold the ids
of a cell. The init therefore never leaves the budget, and it can never
enable a controller, because a cgroup that distributes a controller cannot
contain tasks. The builder cannot create the cgroups and hand them over
either, because nobody can name the ids of a cell.

cgroupfs meets the conditions for holding those ids:

  - cgroup_cell_budget_put() removes everything below the budget when the
    cell is gone. If that fails, the block is never lent again.
  - cgroup_may_change() stops a task of a cell from creating or changing
    anything outside of its budget.
  - The seal already stores an id of the cell on the budget itself.

So set SB_I_LENT_IDS on the superblock of the default hierarchy.

The alternative would be to make cgroupfs idmappable. The ids that are
stored would then be 0 to 65535. The limits of the budget, which belong to
root on the host, would appear to belong to the root user of the cell. And
uid 1000 on the host would own what uid 1000 of the cell created.

Legacy hierarchies do not get the flag, because none of their cgroups is
within a budget.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 kernel/cgroup/cgroup.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index a0836b115c79..3f439ae0e3b7 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -2331,6 +2331,9 @@ static int cgroup_get_tree(struct fs_context *fc)
 	ret = cgroup_do_get_tree(fc);
 	if (!ret)
 		apply_cgroup_root_flags(ctx->flags);
+	/* See cgroup_may_change() for where, cgroup_cell_budget_put() for how. */
+	if (!ret)
+		fc->root->d_sb->s_iflags |= SB_I_LENT_IDS;
 	return ret;
 }
 

-- 
2.55.0

