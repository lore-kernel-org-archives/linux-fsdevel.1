Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B42838F24D
	for <linux-fsdevel@vger.kernel.org>; Mon, 12 Oct 2026 18:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791831082; cv=none; b=lShzSW78UTM/7b6tuRiK4vm5/Ldh7Ad+Fb0j+xiczu9dNHjKXDohfUiSa/urx4TFf804GxdTTp7Yv0XuofIWa5qm7ApKnapvfvkjLAIPcoKt5DfT2O3le1Mt+Wskch/w3aUTovTf4HkF2zLP6KxZnxbQ4nuhuzRt3+C3XYJNDok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791831082; c=relaxed/simple;
	bh=tV93B2USbWXjjDndwiQAqRO3pt+vPvH7KAQSCxUonWM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=V/AhgoESjrfgyIfnzfqjvUlZSADOq8Cflil0P/fHakh+cQxOQHJ+x2GTAYmnZVniNB7beTavUFfjNzKr/F3ydh6KJVokpZhkc/SBC/pMbIZ+V+DLJhVtUDziNlBykxQE7cL31w43Q+5wuLaxT4NbtkW5hqQdJ9ABbhHZ+pk/v8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=pozQDRlq; arc=none smtp.client-ip=74.125.82.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="pozQDRlq"
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-15ea896ddc8so3076904c88.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Oct 2026 11:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1791831079; x=1792435879; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dCiWRkzKBlt1QS3CoF+R9/K21AAXjdQ5fMMqNpuft5k=;
        b=pozQDRlqvuHymaajl1aljEAhNvTDxDVaRPtk5izULri5xkLeiPo15CZmxYVFHmvAG+
         P1sd2U9RPTAn7iRYnKhxr/IqKQhnP28/Qjga+8yDuZpD4WsLnNbghBjCnWkJMBrZ74HD
         MIpFJibtqCxEYPKrHauMLwUUGHNSo8ph1okGL0oH2q5RzJQFiFQGeelPAHZ7EbcjYfo6
         cjBw7HFiSpJQvFINj/KO0f+whxLjcXb/0HiuflAR5CY4vtqsKQgEymPWQmBJuka6argQ
         3q+xKlOB95B82SqZJUT+kI2wcw3daC4YKhzi1B/tiNj28dOmb3DcnaX0pw/X4uarO1R6
         5nTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791831079; x=1792435879;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dCiWRkzKBlt1QS3CoF+R9/K21AAXjdQ5fMMqNpuft5k=;
        b=k/sJDfJPuVqt5zCB388BfXI5jkdRKsAgjvLgJYSAMdy0M8emhbTYuG+q/fYSsF9IwD
         ORnz2179XJGJbJsbiApnxMUPx+/TkbJz+yF3Agf8jtOPuWTWHXbdifEuFRWvmrYAbFWm
         5M48xV30yy+9bvCH4t8AfRQ9jXKpFttIPiEQsuULO3eqLTzgRar12snAOpmZdg/Dml2p
         5uyeukSYyZtlxwbp8fzlf0P08wrdc7PXWpZVW0e6mqKs9m6+tUo9nbHw/PjHjX9kA0my
         V+lWHGQK0d81+Y2+I3qw7GvqkGSbluFxlqpQoLiqlEDnhUeWvfBQqzkZP1euyYK8zb48
         BvMg==
X-Forwarded-Encrypted: i=1; AKwUvBzuoPmRYnVs8++RVQIzfKvxlJ21BAM3aZ8rjt9iIs3C/hyikJZwpBe2YM5BwrL0Pd4edjGrAOMZr4nL6tfd@vger.kernel.org
X-Gm-Message-State: AFq9FYL1OELMN4wFKoh0jGXY/1adCSu6cne6AbhGWgkN6QIj0pQxn3lB
	v7kvTG/WA4yK3GayZEWSxPlfnwM+qdoGBvs0V3NczWv11xDeiRKFX0nUxwFEV+AhV+8=
X-Gm-Gg: AYBFou2Cv7ObEKYaNxJN712FMiI4wqpj2XXQbkCF6iEui8FRDQK2C1m2o5uEj+2/fHr
	KlK6u/w9QOQek/y3x5Zr1INakJvE+sslWc+zapnbJ//0t5x3PS2fZaRrKu68gi+ei5dzPvt+y5k
	xTG65GI0rNTYzvG/FKE2w3QL8KdQzSev0o+9ihrRRuFCKwYu7H3h0mEnapQVi2Wy76+7iiQh8WF
	8HtlTdQZq7QJU9kG9nuU4vBAM2QwnvOSAv8aFrHY5X9Dkp5907ABYiSLHxCjitM/ABts0qRcMmZ
	GD+wtXBMOti+Uly2oIQScbDkoWIuRMit6JYiAmJazFjy6B24C70HRC8U7re3jjElU4SJoF0nHTt
	m3fFtY0HGnx9t3YV9Kj0HcfbtBSOtvZgrGS7nU6lZ9ZM8KDHX5IXMi+b6+7juHdu9S3Gl5kzuRq
	Xgf4ibdGatjYInCByTgg0CWqQwdqHN823fwREbx/5ZIJGM+3Uj9XAhgrBh36CcDT8z7WpzWZyoO
	JXhRTxXBf9gZATFjtGySWSboa8OWlAVapDZekd/fQQdyxlLD/UkJveiyg==
X-Received: by 2002:a05:7022:296:20b0:175:c19:93f3 with SMTP id a92af1059eb24-1750c199477mr4258063c88.38.1791831077751;
        Mon, 12 Oct 2026 11:51:17 -0700 (PDT)
Received: from [192.168.1.106] ([198.8.77.135])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-169a2f17feasm41738221c88.9.2026.10.12.11.51.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 11:51:17 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Chris Mason <mason@kernel.org>, Jan Kara <jack@suse.cz>, 
 linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20261012-work-loop-change_fd-v1-1-3cf4ec349bbb@kernel.org>
References: <20261012-work-loop-change_fd-v1-1-3cf4ec349bbb@kernel.org>
Subject: Re: [PATCH] loop: remove support for swapping loop fds
Message-Id: <179183107703.215281.4436365988182227970.b4-ty@b4>
Date: Mon, 12 Oct 2026 12:51:17 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Mon, 12 Oct 2026 14:47:08 +0200, Christian Brauner wrote:
> LOOP_CHANGE_FD swaps the backing file of a bound read-only loop device
> for another file of the same size. The comment above loop_change_fd()
> says this is for installers that want to free the original image and
> for HA setups that want to switch to another copy of the image. When we
> discussed deprecating it in 2023 (cf. [1]) we found no users at all:
> zero hits on codesearch.debian.net, GitHub code search and
> cs.android.com. The only things that exercise it are strace, LTP,
> stress-ng and blktests. Everyone agreed to drop it. I just never sent
> the patch.
> 
> [...]

Applied, thanks!

[1/1] loop: remove support for swapping loop fds
      commit: d4fabede1da0be116fd4cbd34ffd275e394526eb

Best regards,
-- 
Jens Axboe



