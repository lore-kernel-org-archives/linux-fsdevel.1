Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6161E3E022E;
	Fri, 10 Jul 2026 08:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783670709; cv=none; b=AOFprD1qYAQXApJhxBizicSsn2V09AzkbvcvY/SuyiM38naWH0KF9s7+0L7+yVi4QX7i8pqfbdavZiB96w3yoVLJL3+l1q2QWD5HBYztI8X5TH3PWeb7HXNEUzhmC7pLrmiZneQv5ZJyFbKksM8wUEFuAG3P6IatP6kXA645eJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783670709; c=relaxed/simple;
	bh=6CqSezpl6qqQzqEXP1Y2Q+HFDy+Z34BmrA6H+B09RSk=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=iPYndyErM0zHFe0Y8q14FTSyYx7PgqMXaeTWj3PCT2zpXgEPVMrh+b4GsYVn+NBKFXQj9IzLxG/n+L+aL9DHTFbr2HDwQCEBTz8hS70aY4funzRLiLl41AM+ZH7KcuvbQ/RQ3n3mei0c4LHKmLM9cAyjcRYa3OD1Z3N21CettxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nrT+1Mbp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nrT+1Mbp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F36761F000E9;
	Fri, 10 Jul 2026 08:05:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783670705;
	bh=5uIfJGyOvfnqEZuriQzD7o9YgjRY0SHT+YK3eIy68/4=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=nrT+1MbpSV7Eg3ZIzgjuzlwkfj62ajcAV/aAAyyPmr1xfCOvBtBMGzuhB4zPuBzML
	 vrH7CkaA6kKdoQQMotzq6AOrzqTjencWky6J0g8nkwUxUqNtMzu8vb4Tb5g+07+4VJ
	 OS9gS6hJwxoIQbCokmY2i2dSpFkLkvmzeSksLn5RWNzOFNf3NuHWrQm8RuLq61P+NU
	 Ve5e6JlSBA2AIvuPWQ8XrKgUUm90x+xkKPALrP7v2LO2aP56FHBanHJrUJO2rs6gEu
	 YsIx5j/ImL5i+kgx0D67RMeob+zx2jILFLaof1lCmq50FRRFpz/rRcKrcATaMO71ho
	 jaSDU1B6ToJjg==
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] audit: add FSOPEN record to log filesystem name
From: Christian Brauner <brauner@kernel.org>
To: Paul Moore <paul@paul-moore.com>
Cc: Christian Brauner <brauner@kernel.org>, 
 Ricardo Robaina <rrobaina@redhat.com>, audit@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 eparis@redhat.com, viro@zeniv.linux.org.uk, jack@suse.cz
In-Reply-To: <CAHC9VhTpoOaQhw293UNJ58TP5=qYuNNNvJSQ3tzT=uJ4MmXwXw@mail.gmail.com>
References: <20260703122548.1623981-2-rrobaina@redhat.com>
 <20260707-sippenhaft-teufel-bergbahn-87d9652bea7f@brauner>
 <CAHC9VhTpoOaQhw293UNJ58TP5=qYuNNNvJSQ3tzT=uJ4MmXwXw@mail.gmail.com>
Date: Fri, 10 Jul 2026 10:05:01 +0200
Message-Id: <20260710-zubrot-oblag-gerahmt-01a68a57ae61@brauner>
X-Mailer: b4 0.16-dev-4217c
X-Developer-Signature: v=1; a=openpgp-sha256; l=392; i=brauner@kernel.org;
 h=from:subject:message-id; bh=6CqSezpl6qqQzqEXP1Y2Q+HFDy+Z34BmrA6H+B09RSk=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQFLF/fuyyx8dgWlQtq7/en+NX9/hhS9O693ts0xklnp
 895rzlBpaOUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAiM9Yw/NM5HHVj1i5JF6lX
 06pUlCzSHxUdD5l/cd9ShoeTJk9IU6lkZLhyb1bdguyWXTfv2If0pJZ4W2mI8ttqbdNvcQze1Lv
 PiRkA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

On 2026-07-08 14:39:10-04:00, Paul Moore wrote:
> On Tue, Jul 7, 2026 at 7:23 AM Christian Brauner <brauner@kernel.org> wrote:
> 
> > I need a hint from the audit people whether this is ok or not...
> 
> It's in the queue to take a closer look, need to get the stable-7.2
> stuff out first.
> 
> Are you okay with the VFS addition Christian?  If so, an ACK would be

Seems fine.

