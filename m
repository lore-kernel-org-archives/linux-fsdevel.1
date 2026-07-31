Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4251A4307BC;
	Fri, 31 Jul 2026 13:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785503013; cv=none; b=K5axHk0oYge61eU6r8zNbV2YHGs+ut2seMAAQhNbUItahOfT1j3PluPzWj5DV1ZaZt2kW0yHnEKhvjAY3JSUFbiYH9oBmTeppX3+8cZdZm+jBb6rD8IZHOBS6xC5mXmIVNoeJowGkGh00lYV5UJUpPuhMc6IvUGas6yxJ6NnH04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785503013; c=relaxed/simple;
	bh=eeA8ljEi176nac3Xia2CXqgFEjfxocrDt4d0PfokGzw=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=X2n7f8sQBlTMw89FHvG2cLZp+9495EPVco8lWe/Yai9lL+OSYCQDwv28F3d0jHBzEanaHpx/0lqF1b7b13KgPGG8MFaPSMllwVJJteOvsl5r7TDF6UNk3kC25jWtVSD2YKfIPBhzjX5I2628Vzd6p563xpMMUDod0gTwddslBUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IJlFXiXJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IJlFXiXJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 415041F00A3F;
	Fri, 31 Jul 2026 13:03:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785503011;
	bh=eeA8ljEi176nac3Xia2CXqgFEjfxocrDt4d0PfokGzw=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=IJlFXiXJTPWqlSNY4Ouop40Vn4b+A5q6ohym4B9rYnbe3wxfDnsQJRPp6SVIrFOGT
	 MyCgWVqGjS4+dOk22vfkiNJ3P1vEjZpW5qucWie99ORMCVLzExoA2F1dT2596j7EsB
	 EjXDzMKmtRI/NHD/9ZX41VoPwA3zlHffmXY/qotTUJ6U/INTLWwoe9IBamDIqGEnC8
	 8ylnIQQnwtCQGMEDA8n9G3zvyr38AXpSlg3fcmn68VV1WKbzI91jOFUQ/vApdplCzg
	 64eOeXkovARN8/aW9YzcL51cDOuJ42YX0KQKUGkMBvlPRKbTzm2IppaQJCxiBU8FoP
	 BYativFFBXNxg==
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3 0/1] pipe: only enable the extra wake_up(rd_wait)
 for edge-triggered consumers
From: Christian Brauner <brauner@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 Breno Leitao <leitao@debian.org>, Christian Brauner <brauner@kernel.org>, 
 Mateusz Guzik <mjguzik@gmail.com>, Jens Axboe <axboe@kernel.dk>, 
 Pavel Begunkov <asml.silence@gmail.com>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Alexey Gladkov <legion@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org
In-Reply-To: <amueLRM-DrYbnjLn@redhat.com>
References: <amtbpwrhlNGJ9OK6@redhat.com>
 <CAHk-=wi7EccGaeo2Q5mdcvcQJ8VX7tcJWW2fHkg6vfmHGGX8AA@mail.gmail.com>
 <amueLRM-DrYbnjLn@redhat.com>
Date: Fri, 31 Jul 2026 15:03:27 +0200
Message-Id: <20260731-blechnapf-arten-blasorchester-4e05dd1b2c58@brauner>
X-Mailer: b4 0.16-dev-af865
X-Developer-Signature: v=1; a=openpgp-sha256; l=218; i=brauner@kernel.org;
 h=from:subject:message-id; bh=eeA8ljEi176nac3Xia2CXqgFEjfxocrDt4d0PfokGzw=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTlzFUIeJG2Mf7N0e6LixwfZC4QN9peFHxK8/7Xj/Fbn
 x2fWGwyo6OUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAi9V8YGT52LWc/8ua4hMZR
 hpPdeyrW71+5zHaB/ru0rz9Fd/lu6ZVg+O9y/Azf24zyg3s4/Mp9uxfbfc0UW2b9Lt3CKWbB76k
 VeuwA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

> But then we should name it "epoll_or_io_uring_pseudo_edgetrigger".
> See the test-cases, they demonstrate the same pattern.

Wouldn't pseudo_edgetrigger be sufficient? I think the comment as you
wrote it is ok.

