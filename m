Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27DDD3A4F34;
	Sun, 28 Jun 2026 12:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782650219; cv=none; b=ULhIfyMnbhse42c4wKlh+9ioAoDDy6WdmGd+4HuD3aDLU5vUzSEi5W7plBaRF8O6Svq8PCZyzhxColOz2R+2daSRzLs0qIpQEPtZuGd9ozuOvgKTo9m+asgD0mWe0n65fFjxue7M3MfU1oF9oSEfnlRBThAyiCjz/BGz0h/j+3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782650219; c=relaxed/simple;
	bh=daLM/ZW51+ewMtf63TpPiJQTUHWuDIo2vu2nO/XI3Ug=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=rdIenP0rS90/KDA8vEUbjkt9xvbUQ5fbzR9F5E6XVS26dMPMjcfN3/2Fev2irZxznxoBZ2MslZI8YKgHczRM8uGuDb1Ar3g2BIdWWaAKfVQ0U0PoXI7HdvwBag/sDrRBOxFzEH4uE6+WV7AyX6D7LGrMX1NzhZaTxv4XoajXGkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dXKkGtWb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dXKkGtWb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADFE01F000E9;
	Sun, 28 Jun 2026 12:36:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782650217;
	bh=ztrWcsNGICf3RSZiXTbSvoqRkMmVhds5bTffah+JQMs=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=dXKkGtWbbZCPACYW7rD8yxoTgQOXUnMyCnbu4Fek5ZGBj9ZOUQr7J+7+4J2u6bQ6X
	 dR5Hkn2JB4GxOQ/EhPOedNPOqlpXUZ2MCzWea6PxHFxAd3RYElpmuEmkld79wmceW4
	 8HPrCMHtN4SeG5aT4l+kmvmXO+sIB9JErsSkJWHJFQqdTlW4XmVMVgK9tojOCda4C7
	 SyIF0/QcluewB4kHjXB121z51QWT7Ax6FD9yxaz6J3aeT43jttEWrhlHfF/jhb+3bM
	 y6uWVs5iMPfXyUtC4xfEyVEkuurO9t8Qi9rya8gzrtB5jiYbA8Tp6RcJSo0k5GEwO7
	 5yBa+VOIi6+zQ==
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 0/2] fs: support $ORIGIN in ELF interpreter paths
From: Christian Brauner <brauner@kernel.org>
To: Jann Horn <jannh@google.com>
Cc: Christian Brauner <brauner@kernel.org>, 
 John Ericson <mail@johnericson.me>, 
 Farid Zakaria <farid.m.zakaria@gmail.com>, Jan Kara <jack@suse.cz>, 
 Kees Cook <kees@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
 shuah@kernel.org, linux-fsdevel <linux-fsdevel@vger.kernel.org>, 
 linux-mm <linux-mm@kvack.org>, 
 linux-kselftest <linux-kselftest@vger.kernel.org>, 
 LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <CAG48ez2X1p5Nm2_sU=SK9wUusUO8c3_T-=FGrrOhkm7Kn9Y_7g@mail.gmail.com>
References: <20260622043934.179879-1-farid.m.zakaria@gmail.com>
 <sfv7zc6jboy2oxv7zuyofysas4ncbzenwsuzveiyduisfr6i7q@mx23er7uxdbg>
 <CACCo2jkDuwy5w_yhX8833m+s-rY736pk8xtKjxg3_y_7BCOHeg@mail.gmail.com>
 <24420045-a6eb-4999-ab19-1e344eaba8a4@app.fastmail.com>
 <20260625-atomkraftgegner-hunger-kursbuch-b452ff2becab@brauner>
 <CAG48ez2X1p5Nm2_sU=SK9wUusUO8c3_T-=FGrrOhkm7Kn9Y_7g@mail.gmail.com>
Date: Sun, 28 Jun 2026 14:36:52 +0200
Message-Id: <20260628-ungeordnet-orgel-stechen-36dd64038541@brauner>
X-Mailer: b4 0.16-dev-4217c
X-Developer-Signature: v=1; a=openpgp-sha256; l=1421; i=brauner@kernel.org;
 h=from:subject:message-id; bh=daLM/ZW51+ewMtf63TpPiJQTUHWuDIo2vu2nO/XI3Ug=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQ5iqbNq5C4vPXSKpuDZvsdF3W7STy/4f4pTP32o87EZ
 +3VThMNOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACZiE8HIcDCg6t2lg2qW60Wr
 t/yyWpX/WMi/WP5v+5y1U5e8m33k6y+G/0m5S6SW2AsVcSSd+7ZYL/vUqwkHzreuU+YK/xr1/dG
 0JiYA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

> > Ignoring AT_SECURE, LSMs likely will need a say in whether that ORIGIN
> > thing gets honored or not introducing yet another vector where this can
> > be overriden or ignored.
> >
> > Also, we change long-standing kernel behavior which will be very
> > surprising for any userspace that might implicitly rely on the fact that
> > the system loader is used. So even if we were to do something like this
> > it would very likely have to be configurable in some way.
> 
> I think the proposed patch will only change behavior if the
> interpreter path starts with "$ORIGIN"? That wouldn't work on existing
> kernels unless you have a directory literally named "$ORIGIN" in the
> cwd, because "$ORIGIN/..." would be interpreted as a normal relative
> path.

I was thinking:

You download a bunch of $ORIGIN binaries into /woot on a kernel that
doesn't support $ORIGIN. You forget about /woot and update your kernel.
You have no idea that kernel behavior has changed to allow $ORIGIN to
work for the loader. You remember /woot exists and are starting to
execute binaries under the assumption that $ORIGIN is purely a userspace
concept applicable to shared libraries.

/woot came with a malicious loader and it suddenly gets used - if that
happens in a sandbox noboday cares. Now that $ORIGIN works and no
sandbox might be needed I think enabling $ORIGIN might still end up with
funny surprises.

