Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 064484C2260;
	Wed, 16 Sep 2026 16:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789574506; cv=none; b=Gzl9spYv4Q4Vqpv/LUnz9AFTO8Ib95xSMiojNfohzZLUUm6lWLttzIdq7p3VZC295yIJzwIUmKt7FuyleAECO1U6LQVHHp2gwFYg4ImRM6qVOW4PCb8ZM59aOnTCiL2EtfahE9s++r32LO31g33Gcxe5WnE8A1tvPx67+BipBVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789574506; c=relaxed/simple;
	bh=YU/hzG9bPDHSNt5kph5hYorvnW0pRgfRnOWUQ4sO4Q8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=totNWtOd6hmgligTxwxdcw3ZrT+2uNHwCyJZ5b/+LxXl483fxX3ADeV/4mXqK3RhImJ7NPP+yiyFv2So9sI2S/5pF7rocTvQbjUl9cImfFjzhR1MpjqLVvZQQhMddROaFQtTblutyUfKvvT0HG/0wVjcHmVSiEb1s5hx027WIHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=OT/NGfzh; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="OT/NGfzh"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:
	Reply-To:Content-ID:Content-Description:In-Reply-To:References;
	bh=aqlvDnQzQkOxTRif00ncAPCrAhxZAHVzrV+/8ewwv6E=; b=OT/NGfzh00mKUWMy5/uwqffcIB
	guV8xamRO/FjUvyRhSjhbOiZQCJLqTRrFGQcp8yDfEsuuJObn7kek9VxjnW65dUgBNS5RgfOSM+3k
	WGOwRqyAgYHNigQlaAPrX3KCkLLp+JZ7ZRr+EpZyhy5UIqbVUxDOhnfNW37VLzu7ZvREwDJF37ANu
	s+wMWUcM68zk59t0XE0lSlphTpaDWVPmc6hqxV3sf/m3Ek8vG48fyPghBPg9I3vad+ZQxVy8v94tF
	kNkS/Roce8wSbxj8vXV5/ztisr5j1lcdUsYKtoVB99AkFocxmnhog0EIV0xNPbLx0hoBsMuvmhjbF
	FaqVKc6Q==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1x6s4p-005Hc5-2h;
	Wed, 16 Sep 2026 16:01:40 +0000
From: Breno Leitao <leitao@debian.org>
Date: Wed, 16 Sep 2026 08:57:14 -0700
Subject: [PATCH] pipe: pass a poll key when waking writers after a resize
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260916-pipe-resize-poll-key-v1-1-0f8f04f7dd5e@debian.org>
X-B4-Tracking: v=1; b=H4sIAFm8qmoC/x3MSQqAMBAF0atIr21IB3G6irgQ/WqjaEhAHPDuB
 pdvUfVQgFcEqpOHPA4Num8RkibUz902gXWIJmtsbirJ2akDewS9wW5fV15wsZGis1KaISuFYuo
 8Rj3/bdO+7wdWUwaEZgAAAA==
X-Change-ID: 20260916-pipe-resize-poll-key-017a2180d481
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel-team@meta.com, Breno Leitao <leitao@debian.org>, mjguzik@gmail.com, 
 oleg@redhat.com
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=1966; i=leitao@debian.org;
 h=from:subject:message-id; bh=YU/hzG9bPDHSNt5kph5hYorvnW0pRgfRnOWUQ4sO4Q8=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqqr1gQnA8Jlq2POslrr7Sy0x5Pb6qo3h6q8gGa
 tL10g2whCuJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaqq9YAAKCRA1o5Of/Hh3
 bbIDD/4jaYrKhn+Uw2oyS7IXNuMlHHfOgG2scU4KF/qhBVDUIQ4Wm2xlsfpGFRjDoSD0SCfoCO1
 TSPYkuFyzIIv40UHeewqyTUQcJ5cRDNYPXmHX9etQPOUoOtfSCwfPC7lKEr/bUKOuZEpPrT6yah
 v4eqIx+iomn6GnDzzNZ3kF//sp/RXGwkqy7KPTaz6iRzGlik8Z/l9DD8zQJ1kPqUR6I3wx+m6JE
 B8q6KGSBBVhUK01O5WAWyzPu3hObwgMj6AbxChTMThtpuYQdO/scrzLhEXawi6p5KVg+DNYvdGx
 Dd6RuE8EIQXe3ZnWW0ow7lRXKwPcGWxj21wiNji08W7owE6UB9utMBMJO5LZ8bBssF12iV8c8h6
 SrvGmB8GOS8GWdvHlvqf9oASpoczpXcIBNaj2iJCBXcmomZcMuHBItRQ3NPtt7+L1RYq9kO80n4
 uh6YgvI7FRiZu+MjPozeX9qCpPaAKRWLL09bBtc3IhepfHKBLyvUsBWFO/99lHCpJZA0c7mvDIV
 NJofZMNu494JdqsDkW/++7s82JuIelcllVqAesISwfn1Lc1S8w963AkC2xme1I0aODjIaDDXXJ+
 PbF54djVZFAQjMi/D0cNzY4dAPovZG7aJ3KDz0XDfvnlRmmM3+Bs4cszsi4oJSwpXV7Nqx9hV8q
 8a3f3rN/2w/9HCQ==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao

pipe_resize_ring() wakes pipe->wr_wait with a NULL key.  ep_poll_callback()
and pollwake() only filter on the registered event mask when a key is
supplied, so every epoll, poll() and select() waiter on the write queue is
woken, whether or not it asked for the event that occurred.

The event is the one the comment above the wakeup already names: more room
for writers.  anon_pipe_write() passes EPOLLOUT | EPOLLWRNORM when waking
the same queue; do the same here.  Writers blocked in
wait_event_interruptible_exclusive() are unaffected, as
autoremove_wake_function() ignores the key.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
This is the last NULL-key wakeup on a pipe wait queue that signals a data
or space event.  The remaining ones in fs/pipe.c are all hangup broadcasts
(pipe_release(), wake_up_partner(), the fifo_open() error paths), where a
key would make no difference: poll, select and epoll all add
EPOLLERR | EPOLLHUP to the registered mask unconditionally, so those
wakeups can never be filtered out.

To: Alexander Viro <viro@zeniv.linux.org.uk>
To: Christian Brauner <brauner@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: mjguzik@gmail.com
To: oleg@redhat.com
---
 fs/pipe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/pipe.c b/fs/pipe.c
index 292425a834dd5..5791db016e242 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -1433,7 +1433,7 @@ int pipe_resize_ring(struct pipe_inode_info *pipe, unsigned int nr_slots)
 	spin_unlock_irq(&pipe->rd_wait.lock);
 
 	/* This might have made more room for writers */
-	wake_up_interruptible(&pipe->wr_wait);
+	wake_up_interruptible_poll(&pipe->wr_wait, EPOLLOUT | EPOLLWRNORM);
 	return 0;
 }
 

---
base-commit: 587858367581b9c55c3690f4e63382ad622719d4
change-id: 20260916-pipe-resize-poll-key-017a2180d481

Best regards,
--  
Breno Leitao <leitao@debian.org>

