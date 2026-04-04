Received: from erebus.slow.network (erebus.slow.network [109.74.205.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 839DA2BCF46;
	Sat,  4 Apr 2026 12:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.74.205.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775304725; cv=none; b=Q48Mqf7uwA2okWkoVBJMmCxsISWAwBxV7dY3cyQnHJx7an5WzQhqU9TPNv4UiVD5nzcZ5uW5SaHoITqs0H+BOUw7HDHy2y//pdlltOWgWZ6f2UM6HIKOiStto8A4mQ/Ftk5IF4jfE8kUn8GU/pPvgsYpWEoHxhzA0cYYgSvW94E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775304725; c=relaxed/simple;
	bh=45DZpDUBM7LqUogKK6H+9umMCSfaRLd3l6CIldm2Am4=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=Kgv/uR4J3AGGiBMsYVm1Mio9eN3DPUdnBVzLLgrQ3B9swPzTWpivkP7N1Cj+Me7cD1herYJGlMjUTYy619/7RoE9dUuhQtKQu+Qt8rdc4A5gsnsfV+shzgAfSJH6Di1WrLGM4YnE36faRsE4+BRQUDWSUYqTlZKgy7rnTI4/91A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kramkow.ski; spf=pass smtp.mailfrom=kramkow.ski; dkim=pass (2048-bit key) header.d=kramkow.ski header.i=@kramkow.ski header.b=vakMFKji; arc=none smtp.client-ip=109.74.205.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kramkow.ski
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kramkow.ski
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kramkow.ski header.i=@kramkow.ski header.b="vakMFKji"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=20220506; bh=45DZpDUBM7L
	qUogKK6H+9umMCSfaRLd3l6CIldm2Am4=; h=in-reply-to:references:subject:
	cc:to:from:date; d=kramkow.ski; b=vakMFKjiw6GhSRK+Gk9o6T0sy9yc+K18vIZ3
	+sJ7tDyTYd+oGkIDnoOQ+M6hKs8y8egb9CpY2PdkfpiqUSfagRtpNUh8iXkR4L/20NC3qO
	SDpycpanOpUWAbXhKNwLfq1O9E77ax5nBg5rpbH8wH46YRcWmAO9IbLqp5uiTdtBWUwkXQ
	4p1Kwg98l7jL1wjb6vcSUhXfdsfKeh/49HfgS0A3o/4cwIr8jza+5gPpylDlitHp1ttlEp
	K0MoAm6R87rihXuGFjrZ5fAQxRFiGbIUQX52SVtcPO6oYYMRG010+r6HZGoQiG1n/N1JAf
	heEtPz+6ESdeqfaBod7agYBlrw==
Received: from localhost (flit-04-b2-v4wan-169180-cust382.vm32.cable.virginm.net [81.96.161.127])
	by erebus.slow.network (OpenSMTPD) with ESMTPSA id 78bb1561 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Sat, 4 Apr 2026 12:11:58 +0000 (UTC)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 04 Apr 2026 13:11:57 +0100
Message-Id: <DHKD00A8F4MN.3394SJ86VMD72@kramkow.ski>
From: "Tomasz Kramkowski" <tomasz@kramkow.ski>
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 <stable@vger.kernel.org>
Cc: "Christian Brauner" <brauner@kernel.org>,
 <linux-fsdevel@vger.kernel.org>, "Tomasz Kramkowski" <tomasz@kramkow.ski>,
 "Brad Spengler" <spender@grsecurity.net>, "Alva Lan"
 <alvalan9@foxmail.com>, "Al Viro" <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH] Revert "xattr: switch to CLASS(fd)"
X-Mailer: aerc
References: <20260404112219.389495-1-tomasz@kramkow.ski>
In-Reply-To: <20260404112219.389495-1-tomasz@kramkow.ski>

On Sat Apr 4, 2026 at 12:22 PM BST, Tomasz Kramkowski wrote:
> Was asked to send a revert instead of a fix. Previous patch was here:
> https://lore.kernel.org/stable/20260403230636.344097-1-tomasz@kramkow.ski=
/
>
> Tested via qemu to verify the fix and ensure there were no unexpected
> consequences.

I should note, however, the backport was intended to fix a specific bug
in `fremovexattr`, and now that bug is there after the revert.

Shall I just submit a v2 of this with the revert _and_ a new backport?
Or would you still prefer to just revert and then have attempt #2 at the
backport separately?

--=20
Tomasz Kramkowski

