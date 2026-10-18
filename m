Received: from mail-qk2-f11.google.com (mail-qk2-f11.google.com [74.125.230.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E5903D9691
	for <linux-fsdevel@vger.kernel.org>; Sun, 18 Oct 2026 16:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792342213; cv=none; b=lWxztRXl2sRY6Kyr474fJpNEUaeB+Vl5FzBSWiAR0WSaDbE/vLU0inoMAT6lTVXKcjgLwXiIurWfVJXlmBqG+8HLYpn2AkHlKYdYKUZjs2uhkaXjzOVxLss8oV8vHgcNHwUQ5lfy/k/gXQ3mt6hH5apyIomgN0HKfnKzgzneEh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792342213; c=relaxed/simple;
	bh=Un8SXnxmeMZ0/+JHzIEU6RF8y5fORfeQWzRYSwHWMBo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=h7TaPY/ZFUJB9Q0jQKUgLn5Fwqngwvn6jODtAPQvVE8hXwZ32JH7yab0kPr/dMLnSnSnJP26y6N0PAdIZX/jh2fvD1lZOXPXzagefM762VGRDSUspUxv8rSrl46jFasdn6EG5WgHZkuKE319LkLf4au4nD7QI2TFIXk4U0B1nNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mHvwrGjL; arc=none smtp.client-ip=74.125.230.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mHvwrGjL"
Received: by mail-qk2-f11.google.com with SMTP id af79cd13be357-93e490d7b48so47567085a.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 18 Oct 2026 09:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792342211; x=1792947011; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=tKvxLvNr2Cvow2Okndn43Axal8wMwUyP3NZs7lyino8=;
        b=mHvwrGjLON/HeixKrQALJuiOIRQPKYJ46MdNQUKJtyu/6QtVlzZlz4ZxxbZTL8GXuZ
         ZS8HSOlBhpFlz7tqnOcQLlqOUhgUeeHSEGkgFv4JAbt1/1AtuhEt5SDOvk+ypOYLNfJi
         jg2c9nym9hJPKNICwXGCNUQTA9w8Ap8tSnIexEUfRZM5p2pTGhOzE9JGfAD/QW/n/t+m
         uphr4JvDDIOzhbQU/Kgt4ay2LkRFIr+OGhw0x2xdyOk9iQcgJlmpr7qEcNJSC5vu5QyL
         9v2g1qEF4txF3IlXJ8tx6mRdzN4MpB9v2TnTEnIJf6Oa0Aa3zjg7FzTL8yYAP4gjz9z1
         e2cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792342211; x=1792947011;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tKvxLvNr2Cvow2Okndn43Axal8wMwUyP3NZs7lyino8=;
        b=rvl0Xxd1OffY7rftBbwAxKVNFZSQXC0+g7XAg5f7MYEZujJaQ63Zj8dIseZNdAZueJ
         BjpNx7FZMdlWyTnzXPrhMYT/eLe1699VFBIYezXXJPSNBfaRhtD+c+nbno4tUJii+AsN
         axGczDdL/Pjww5EGslrnWWIzesAmre9MqkiIW0fFA0FLV6KGd2dXUBxvtlf6GsfwDIBY
         MG8TPZFiTjzMpT93rNLedF76SWg8erCD4fNF9mOnjv7Jwfx8eMC2YsETNrIdF0W6UIVj
         daJnP6SPmRJsUMXVXgf37QB/kMBMZX28QqJZ5AJRPWurrT1MztrEY1AsA640UOOeDt0L
         ltsw==
X-Gm-Message-State: AFq9FYLLJHb+E7/XrRkSItEptU/25G3zwFboL5SPe/2VbvTVYu4UcyWS
	s/pTiMPTOI1geKRUYg8x6aWOZJhIcvWId3FS0G8P73o2nrVY/r27s5NR
X-Gm-Gg: AYBFou13MiZ/HWiCG3QxoJJ8ZAudoTJK0hxS/wx9RSV9P+T+G2HmtIf9KqEZaym7XP6
	mc/8fVsyIp5C74SC7dAPGR//DBfUuyn+pzOm2uri5E8QAEMgiTj0/bygQ9DoptjqwcoX6FQrGvO
	i43yB/lop50xf65W6VBnyLPrDE5du8qpODmY99bK/k1tboqe3gDRT/19QaAnGvoLj+5nHCjmYkB
	fPgx7nqPlQdivS3yDnTYz9zawPg2Ft3/WtyHaMyCVE6HP5LD93ZxyYoqG9UUkjXd0jnqL0OjjCu
	f/73sKkDmO0R7gXCcVQA46uuL9lrWMEY5zuxtcEJ4c/ebp0JGYtOt8XSQb0j8UN6L+/QRKsSTAV
	gbI5Dt3fRxs7q6q71/m8MoSozYPHtJKx0+jYoH4k3ieoEocSLWH8vbIXVnc+WcZ2oY8PzMxPnH0
	5ty9cRlcVUoTkutKHPqRiQ9syyifoqgKLMX6vpAtI367OES5LT1uPdiLLj6fIX+Jjq/OHbfoP2F
	tXqi1s=
X-Received: by 2002:a05:620a:6f87:20b0:93f:2bc8:283d with SMTP id af79cd13be357-93f2bc82bbemr560917085a.47.1792342211235;
        Sun, 18 Oct 2026 09:50:11 -0700 (PDT)
Received: from Fujo.localdomain ([142.188.41.221])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93f1a1688aesm740116685a.8.2026.10.18.09.50.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 09:50:10 -0700 (PDT)
From: fujo <hooyan2024@gmail.com>
To: Oleg Nesterov <oleg@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
 linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH v2] selftests/pidfd: wait for POLLHUP before reading exit info
Date: Sun, 18 Oct 2026 12:48:50 -0400
Message-ID: <179234213014.649.13402722495876323247@gmail.com>
In-Reply-To: <atTy6LziL5fdGTkn@redhat.com>
References: <20261017054356.7874-1-hooyan2024@gmail.com>
 <179226499044.847.17334319321039510150@gmail.com>
 <atTy6LziL5fdGTkn@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Oleg,

> This chunk doesn't look right, POLLIN makes more sense in this case.
> Unless I am confused, this poll(timeout = 0) tries to verify that the
> child does not exit and report POLLIN, with or without POLLHUP.

You are right, thanks.  That poll() is a liveness check, not an
exit-info wait, so v3 keeps POLLIN there and only switches the polls
that are followed by PIDFD_GET_INFO.

About the documentation: there is no in-tree KAPI file for this; the
wording I referred to is the CLONE_AUTOREAP series description ("poll
the child's exit via poll() and retrieve exit status via
PIDFD_GET_INFO").  If you or Christian think a clarifying sentence
belongs somewhere in the tree, I'm happy to send it, but I didn't want
to guess where.

Thanks,
fujo
