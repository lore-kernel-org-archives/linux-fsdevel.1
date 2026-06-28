Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79463282F28;
	Sun, 28 Jun 2026 13:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782652818; cv=none; b=go0R63pV/idMk8OMf+zihAFjJK4pE10raW5XEOC6sZt2h2wD23vlidbhPi8qwAVX7i7RDn7iftXK+/smBv2O1ibWAtiFiCZtbhFG18EJk1J8Z0Z0SuVzz77rOmuZOBY4QhBpOTLzXjR6hbWvbLyrKSIKVUeStlNhsoLG4eay57w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782652818; c=relaxed/simple;
	bh=iEXwwCjxyid4ZfFr2P+Mp82+XoX1Wd5fAjKvPPhBb94=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=EadjVe+X7P6nMz6u/XIW8bFwN0BSTnd0GiMrzysTVQ+je4r8LyWg1ZZjXLqcNT4AJpYB21V/TxIZ9KNfIJ6TeIcPCEf55QQSqYyFQEqoa7lT8Md5Y+oyh19CoZv3C7GAB+A3Sk3z4TLTX/R2Q1u20BD9cpJyTlAhC+smskzpdDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T58wKw3/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T58wKw3/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F3AC1F000E9;
	Sun, 28 Jun 2026 13:20:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782652817;
	bh=JXoQjZLUk0Gu2GsfbmsyigRTgwTQyOHHwu7BBNkqboI=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=T58wKw3/h195JJKQslgax470vRU1moZzYMEaQLAo0MoeU72pEf8B43+d3jCrLorTI
	 SwkW7RJWoNeW+/Wlt8uFGkacN2dNc21vnPhntK7zSRu9W7trR+WCW6WmDwW4oGWGci
	 Lg65sOJVYJ7fVZ8OBSDwP0hygUcnbt1ZVZ3OHesiSeYjzRXxMokmWB+3bpHKKiH8Ar
	 HpWbTudaosHJDfaenjrQhyqaOR3OtMr4qXm6CJgd6w+QJLYKy1DBjPu00Uo7GuMK6o
	 lo/6Pvu9d4bU0QpyCBgbY43irSMjUq9QTCEUgPgSQCU0hkF1tvh51Uui+Y2mQ8RcTl
	 YvEA66rRM1a5A==
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
To: Christian Brauner <brauner@kernel.org>
Cc: Jann Horn <jannh@google.com>, John Ericson <mail@johnericson.me>, 
 Farid Zakaria <farid.m.zakaria@gmail.com>, Jan Kara <jack@suse.cz>, 
 Kees Cook <kees@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
 shuah@kernel.org, linux-fsdevel <linux-fsdevel@vger.kernel.org>, 
 linux-mm <linux-mm@kvack.org>, 
 linux-kselftest <linux-kselftest@vger.kernel.org>, 
 LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20260628-ungeordnet-orgel-stechen-36dd64038541@brauner>
References: <20260622043934.179879-1-farid.m.zakaria@gmail.com>
 <sfv7zc6jboy2oxv7zuyofysas4ncbzenwsuzveiyduisfr6i7q@mx23er7uxdbg>
 <CACCo2jkDuwy5w_yhX8833m+s-rY736pk8xtKjxg3_y_7BCOHeg@mail.gmail.com>
 <24420045-a6eb-4999-ab19-1e344eaba8a4@app.fastmail.com>
 <20260625-atomkraftgegner-hunger-kursbuch-b452ff2becab@brauner>
 <CAG48ez2X1p5Nm2_sU=SK9wUusUO8c3_T-=FGrrOhkm7Kn9Y_7g@mail.gmail.com>
 <20260628-ungeordnet-orgel-stechen-36dd64038541@brauner>
Date: Sun, 28 Jun 2026 15:20:11 +0200
Message-Id: <20260628-debatten-vertagen-amortisieren-3bf518773e75@brauner>
X-Mailer: b4 0.16-dev-4217c
X-Developer-Signature: v=1; a=openpgp-sha256; l=2418; i=brauner@kernel.org;
 h=from:subject:message-id; bh=iEXwwCjxyid4ZfFr2P+Mp82+XoX1Wd5fAjKvPPhBb94=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQ5yvfpGvgGyOgzlOotv/p9s/+c+m3O2xgLvZwmNTJeW
 r3AeLpXRykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwES81jD8T7zvks7EoT1j4+We
 RXfTDUQuVVX11Xx7XF3GLvV3khvPeYZ/JstLjUMu3Zs+0/97ncChzoavG1eomwlM1isIXnXln8B
 sXgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

On 2026-06-28 14:36:52+02:00, Christian Brauner wrote:
> > I think the proposed patch will only change behavior if the
> > interpreter path starts with "$ORIGIN"? That wouldn't work on existing
> > kernels unless you have a directory literally named "$ORIGIN" in the
> > cwd, because "$ORIGIN/..." would be interpreted as a normal relative
> > path.
> 
> I was thinking:

A few other things came to my mind:

(1) memfds: /memfd:woot-woot

    A memfd doesn't have a path so any $ORIGIN type behavior - script or not -
    will be at least useless if not very confusing outside of a sandbox.

    Btw, used by runC to guard against binary overwrite attacks.

(1.1) deleted memfds: /memfd:woot-woot (deleted)

      Same as (1).

(2) deleted executables:

    /woot/woot-woot (deleted)

(3) unrecoverable executable paths

    No path can be resolved at all. What to do?

All of that needs consistent, easy to reason about treatment. Reading through
the glibc implementation of $ORIGIN for shared libraries in rpath - even with
an eye on cutting through most of the complexity - doesn't give me very warm
feelings. It feels very hackish and full of edge cases...

Imho, tying the lookup of the interpreter to the binary itself and making the
kernel responsible for figuring out the relationship by resolving bprm->file
and splicing it with PT_INTERP is terrible.

So, I kinda like the concept of having relocatable dynamic executables but then
let's cut through all the userspace red tape and figure out something that's
super simple and outsources the problem to userspace.

I think the wrap-buddy approach here: https://github.com/Mic92/wrap-buddy is
going in the right direction in that it gets the kernel completely out of the
way. I like that a lot more than moving more nasty bits into the kernel itself.

In a way we have been doing something in systemd that goes in a similar
direction. As of systemd 261 systemd _only_ links against libc and nothing
else.

Any other shared library is dlopen()ened as needed (discoverable via
elf-notes). Lennart wrote about this just a few days ago:
https://mastodon.social/@pid_eins/116781776665322560

This effectively minimizes the work the loader has to do at startup. Imho, your
effort with wrap-buddy is related. To me moving the loader invocation out of
the kernel and into userspace makes a lot of sense to me.

