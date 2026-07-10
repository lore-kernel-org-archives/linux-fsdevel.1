Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 322B2314A98;
	Fri, 10 Jul 2026 21:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783717561; cv=none; b=EV3H7zTAKTRkWBJx+KslZpIZbq2jEK5bxJxK+dTSlyXF2B5nbPrsbVkeqtdjobFtWvkL3vqkc18PVfl2ODzoVrb6pYrHcVMLkh2NU+hcdk8c2V3MGUfn0RtE9ab/stgEAbXC2CegIChfkkBxIz0VqG8wPe0ztEOOBSEfTaPXjVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783717561; c=relaxed/simple;
	bh=bYq2PKBJrFL5yPlruayiPjNM3gZXdC+7flBtzGyiXQU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ud8iLY/KvrP7Xs24o5vDUXTYtnP2DMni37kfP9BBkJQ7KB+0epOAI8LWjuGad3Y3VwMkewgsLa5uA1wVipUhg/gkO3n0jIeUnOlZgH2Kd+nKzMMT1q6UlvON+HcNCUHwcG4kJLgmicvzpSEI/i62yeckRb71Eyg4wn8fLxyzkfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nb7/e9FG; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=krqhwJ08; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nb7/e9FG";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="krqhwJ08"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1783717558;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=odZn7xUGxtd1QXpXKUzqfazm9EGXA1FkdzIRW2c62cA=;
	b=nb7/e9FGkBxam/YjLAmRX0Vmg+N7cXT6jBHwfWf+LuZ0WGQNx/kX0xHk+d2Nl2UR7uAOyV
	6nvb6RwcGkNBRmVhNcpbcgi3sLsuYF4Fzauf2izMPfb7XBaoQRjh6QF3iIZnnGiT+Ibkeh
	9SHIiVAnIYYKF6GQuYYdb5fY1zUeWI21LH25upyfn0fCuHpWRrKko31G1j+v63YESaD8Fe
	9yIYqsJsw//gnTnwPbhNwM0wDZmlJOY9IcgDoUkyRge311sD07+rl3/XcrelK2lkEuhLmI
	nHQarsVhPeKNkQMBxXReXB+xXATIBc8In8YCxP8HI/wPhxQw/HhGi0j3Ni7jwA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1783717558;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=odZn7xUGxtd1QXpXKUzqfazm9EGXA1FkdzIRW2c62cA=;
	b=krqhwJ08CWOyjvQH9l+Kddx1qONIn6q15oQnAIjgjRrH75NdVIYOxklzVus88XWdtBIIl6
	ehQ5lHUFs8/clgAw==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, Steven Rostedt
 <rostedt@goodmis.org>, Andrew Murray <amurray@thegoodpenguin.co.uk>, Chris
 Down <chris@chrisdown.name>, linux-kernel@vger.kernel.org, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, linux-fsdevel@vger.kernel.org,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 linux-doc@vger.kernel.org
Subject: Re: [PATCH printk 0/3] Introduce sync mode
In-Reply-To: <20260710144609.194487-1-john.ogness@linutronix.de>
References: <20260710144609.194487-1-john.ogness@linutronix.de>
Date: Fri, 10 Jul 2026 23:11:57 +0206
Message-ID: <87cxwu4ksq.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2026-07-10, John Ogness <john.ogness@linutronix.de> wrote:
> As proposed in an LKML thread [0], here is a series to introduce a
> new console feature to use synchronous printing.

So the Sashiko review [0] found all kinds of issues and every one of
them are legitimate. In particular, I totally forgot about:

- the console_lock synchronization when boot consoles exist

- the various sites that _rely_ on kthreads printing when
  printk_get_console_flush_type() reports ft.nbcon_offload

I will consider each of the points mentioned by Sashiko and include my
proposed solution in my response. I will need a few days to go through
all of it.

John

[0] https://sashiko.dev/#/patchset/20260710144609.194487-1-john.ogness%40linutronix.de

