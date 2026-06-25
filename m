Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 432C738655C;
	Thu, 25 Jun 2026 08:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782377458; cv=none; b=i+hQh2sMLoVecR7E+p4jCBmPqTE7/h24Y/FpnLBfJUlKSTYOwxOubtLvu6aVaDCGV1C6HolNR6+DSnejhDLZCto3WAQPS66JArTzS8H/vw+uOg/hg/XWvRmDNOVnbr0l01TcN3cVaNlcs0HoVk9B9XK6XbmoaE89YQ/VM3PRqmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782377458; c=relaxed/simple;
	bh=YWjLajG3jUSlfnNHIHqvQH7npOW2FoDppQt4WSwGrdY=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=Ii4TPveAThp/mBEEnrjwWday4CbsfP3lGU1lA8mmjCmnepViVq0eQ7IimSYV4RuepPWMuDpJqyaF/LQJ5AHtj6QpreUMKD/wzhDwtWPridFBWVGgGwka/5hPosgKaGfiAxyAq7IlB8AHAN8IJ0WhJRj5ygHXBqOIagzdWzw2ekM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mit2xoCJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mit2xoCJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAD931F00A3A;
	Thu, 25 Jun 2026 08:50:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782377457;
	bh=2OPM2QsERty8ncczG0J+oScu2vAmciLsKe1D4GkLBlw=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=Mit2xoCJBPEjBNx0LAYKxG3Cj3APh7/SkQ5Ko2v0NtcvZNcFPqpYoQiAvNwsLX1tJ
	 U4Jn66pXvAalZ5osrav9nyxvrhb19PCq5cEWHWKt1VkLezWyVh+RKC7P0R6Xx5KY5X
	 hdlsN6mDxbF8Ice+x5WO7sgORA5SEFX5gzDrGBBiOyqplfaogfRLMOcZwwWWRdenwH
	 q4iq+BpK5UyGIAfO5gUXEUnGUqDVDAEZUAjiTrJX/W8ahqugi9vBKJUe/wYnsWtXr0
	 vfbIK6qTPpk9/tJY05vcccFsN1HiQMHZzc0uy0VckYBNpOOd3YJzAa9OXd0BQdxyPT
	 2U/RCre0IQP4g==
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 0/2] fs: support $ORIGIN in ELF interpreter paths
From: Christian Brauner <brauner@kernel.org>
To: John Ericson <mail@johnericson.me>
Cc: Farid Zakaria <farid.m.zakaria@gmail.com>, Jan Kara <jack@suse.cz>, 
 Kees Cook <kees@kernel.org>, Christian Brauner <brauner@kernel.org>, 
 Al Viro <viro@zeniv.linux.org.uk>, shuah@kernel.org, 
 linux-fsdevel <linux-fsdevel@vger.kernel.org>, 
 linux-mm <linux-mm@kvack.org>, 
 linux-kselftest <linux-kselftest@vger.kernel.org>, 
 LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <24420045-a6eb-4999-ab19-1e344eaba8a4@app.fastmail.com>
References: <20260622043934.179879-1-farid.m.zakaria@gmail.com>
 <sfv7zc6jboy2oxv7zuyofysas4ncbzenwsuzveiyduisfr6i7q@mx23er7uxdbg>
 <CACCo2jkDuwy5w_yhX8833m+s-rY736pk8xtKjxg3_y_7BCOHeg@mail.gmail.com>
 <24420045-a6eb-4999-ab19-1e344eaba8a4@app.fastmail.com>
Date: Thu, 25 Jun 2026 10:50:52 +0200
Message-Id: <20260625-atomkraftgegner-hunger-kursbuch-b452ff2becab@brauner>
X-Mailer: b4 0.16-dev-d9d01
X-Developer-Signature: v=1; a=openpgp-sha256; l=6562; i=brauner@kernel.org;
 h=from:subject:message-id; bh=YWjLajG3jUSlfnNHIHqvQH7npOW2FoDppQt4WSwGrdY=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTZvH4nE7tbujU0/s/WsOh44XiL7RvXiPQUNz/+taiyQ
 fEY95kFHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABN5JsDI0NwWeqnwedgvs+Nf
 NPVn5cp2q1b41m/SMf/y3mmPSf0FU4b/iYxZEdvvRB0RLM7ZqLxfvfPybl4Oya6D7IEKjqvPfdj
 ODwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

On 2026-06-22 17:08:55-04:00, John Ericson wrote:
> Hi, I am another Nix developer, and have participated in some LKML
> discussions in the (recent and distant) past, and thought I should weigh
> in here too.
> 
> On Mon, Jun 22, 2026, at 1:15 PM, Farid Zakaria wrote:
> 
> > On Mon, Jun 22, 2026 at 3:40 AM Jan Kara <jack@suse.cz> wrote:
> >
> > Having put forward the patch, I'm clearly biased toward thinking this
> > support should exist in the kernel.
> > If I had to think to strengthen my argument would be that the kernel
> > should not be imposing how the interpreter is found on userland.
> > Finding the interpreter relative to the binary would be useful for
> > package deployment scenarios similar to app-bundles beyond systems
> > like Nix -- which is the originating reason why $ORIGIN exists in the
> > dynamic linker.
> 
> Yes, the idea of making "relocatable software" is not a new one, and
> indeed it is why `$ORIGIN` is supported in the RPATH etc. in the first
> place.
> 
> Most of the programming model for writing relocatable software is fixed
> at this point. For example, /proc/self/exe made it much easier to look
> up arbitrary stuff relevant to the current executable. It is just some
> initial entry point stuff (the ELF interpreter, and shebangs) which is a
> glaring exception. Those should support `$ORIGIN` too. There is no good
> technical justification (that I can think of) for some but not all of
> these supporting `$ORIGIN` --- either it makes sense everywhere, or it
> makes sense nowhere.
> 
> (I suspect the only reason it didn't happen was pure inertia/Conway's
> law --- easier for whoever was excited about `$ORIGIN` to change the
> glibc loader than the kernel.)
> 
> > To me, the gap is that prior to systems like Nix, the idea of wanting
> > your dynamic linker to be part of your app bundle was not necessary
> > but Nix models the dependency chain down to the loader. Such
> > functionality would be even more correct for these other bundled
> > solutions as well, making them portable across userspace glibc
> > versions for instance.
> 
> Yes, exactly. Traditionally people thought "eh `/lib/ld-linux.so.*`
> doesn't change too much", and decided relocatable software that
> nonetheless hard-coded that absolute path to an unknown system-provided
> ELF interpreter was good enough. (Or if they weren't good enough, they
> went with static linking, but that imposes other costs.)
> 
> Now there do exist purely-user-space work-arounds, like
> https://github.com/Mic92/wrap-buddy, but they are quite complex, and
> involve various patching trickery that is likely to scare a lot of
> security analysis tools. A kernel-based solution that allows clean
> declarative expression of intent with `$ORIGIN` is much more elegant.
> 
> > > In particular the
> 
> I think it is good to see what Conda does as documented in
> <https://docs.conda.io/projects/conda-build/en/stable/resources/make-relocatable.html>
> and consider why relying on namespaces vs good old-fashioned relocatable
> isn't good enough for them either.
> 
> (I don't doubt that Conda would find this approach more robust than
> their sedding tricks, and prefer to use it where possible.)
> 
> The short answer is while all of us in the build system space love
> sandboxing during the build, we don't want that to lead to *requiring*
> run time sandboxing of the built artifacts. For example, we can
> certainly arrange sandboxing so `/lib/ld-linux.so.*` is the one that
> some executable expects now, but every time that executable is run, it
> *must* be run in a root filesystem where `/lib/ld-linux.so.*` is the
> loader it expects.
> 
> If you have multiple programs that (for whatever reasons) expect
> multiple different loaders, all spawning one another, it would
> potentially incur quite the development cost to ensure that they all do
> the proper unsharing to make everything work.
> 
> Relocatability recognizes that whether or not namespaces exist, in an
> "open world" scenario where we don't know how the software we are
> writing will be combined with other software for deployment downstream
> in different ways, it is easiest to adopt an idiom where different
> things can be placed at different absolute paths, at the user's
> discretion, and so conflicts are always avoidable.
> 
> > > Anyway I'm pretty sure Christian will have more educated answer than me but
> 
> Waiting makes sense, I am curious too what he will have to say.

The arguments I have heard from various people so far are:

(1) Userspace would be able to clone a random chroot to /woot and run a
    binary from it without having to set up a complicated sandbox
    effectively making dynamically linked binaries more like static
    binaries in a sense.

(2) Quote:
    "If you debootstrap/dnf a chroot to some location in your
    home dir and try to run a binary from it, that it tries to load the
    libraries from your /usr is a pretty unintuitive and not at all
    useful behavior."

(3) Quote:
    "[Various remote execution things run in locked down containers that
    disable userns, which makes the sandbox impossible and hence our
    builds wouldn't work there."

I'm discounting "Oh, userspace already allows this so why not the
kernel.". I think that's generally a bad argument. Kernel and userspace
aren't really alike in that regard.

The userspace ORIGIN concept is guarded behind AT_SECURE. The kernel has
to enforce the same rule. That means the loader now depends on the type
of binary. I think this is a rather serious issue.

First, it creates confusion in userspace what loader is used. Second, it
means anything that any build/chroot that uses AT_SECURE binaries now
has to use the sandboxing solution anyway or risk that some binaries use
the system loader and others the chroot loader.

Ignoring AT_SECURE, LSMs likely will need a say in whether that ORIGIN
thing gets honored or not introducing yet another vector where this can
be overriden or ignored.

Also, we change long-standing kernel behavior which will be very
surprising for any userspace that might implicitly rely on the fact that
the system loader is used. So even if we were to do something like this
it would very likely have to be configurable in some way.

This makes this all ripe for malicious loader injection attacks. And we
need to consider this possibility.

So I'm not enthusiastic about this. I want this to be consistent.

