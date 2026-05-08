Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8DE7396D14
	for <linux-fsdevel@vger.kernel.org>; Fri,  8 May 2026 23:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778281395; cv=none; b=aFr0vZMLUmqyRwzB8ODgnK9JrpZC/2tmcJm7Z7YAD1fxylYAsvda3jtqJZY34F6hfdoV8z5BTWbGD8OiztNcAkBBy6++V6i18B8JqVKOIdV2HwlyBFXr+KIFPC/WFTNuV+MObPfaNAge4BRDXBq5SFfRCqbhK6c4EjhmrTUO1ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778281395; c=relaxed/simple;
	bh=j5N3oZmK7dYmKPs7BKMIqu3wVGGm5AbEtgiIKGJAjog=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZbC9tggPS7abEVwJnIu3gbyTT29gb5OJCU9nD6d2bw95U2L7OSRiQRPR3uo+CIfL+6wTIP2drG5NaqYSIpEGKYKmvV8f59V9D36Zd+0Sgy/S4x+dVtxEBbsKRHDoRWsWQLo6TCAM2rI87PUQwHgyDuEuWrZTMajklWwxNnm+6Ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=k9Jp1CZp; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="k9Jp1CZp"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=hZWpmYV7QN6WoRgH+tL8lCuHd8UlK5sTK4cOYCy9DKI=; b=k9Jp1CZp+M5WiTRoBrzLd8R/C1
	EKpl+rGVdYORLudQQzlbQgis5/+Y3BowviVvLMnqS7Wx0eocxPLkxVVQY5fH0MMxq/syCAAe7ffWn
	mMIGhx7QCiYjLY2H1YaD2trC2KHFAZMhgpcBaY5WrT2rI36iaUxtusIo2MtAr3kcaQu+q8+Qo3u8+
	MTjeBJ+krcsxh3wM5QEMd8VFb7f8gLCz1jOHUTWMrEKXQtoQrlXobtXpv5z9+I9Gz0ahPQeI6EwaH
	6B5ApfdVXc+Q09S6q/NmyI0PdkkteneaSV79LMiuQtprOz2tm7Cz5FY8N0Max529owLf6m/W6nXMk
	Y7BJ8imA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wLUEK-0000000F5IU-0MOO;
	Fri, 08 May 2026 23:03:36 +0000
Date: Sat, 9 May 2026 00:03:36 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: NeilBrown <neil@brown.name>, Frederic Weisbecker <frederic@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Boqun Feng <boqun@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Uladzislau Rezki <urezki@gmail.com>
Subject: Re: [RFC PATCH 20/25] d_walk(): shrink rcu_read_lock() scope
Message-ID: <20260508230336.GC2636677@ZenIV>
References: <20260505055412.1261144-21-viro@zeniv.linux.org.uk>
 <CAHk-=wj9WdmFn=gw4c0+mv9dLCGFsiawF60Eu3Kw3t8SfvpZsw@mail.gmail.com>
 <20260505200501.GF3518998@ZenIV>
 <afpj3FBrvHer0E6Y@pavilion.home>
 <20260505225028.GI3518998@ZenIV>
 <ba887c23-9122-40c3-86ff-95e3a5afdc7e@paulmck-laptop>
 <177819357555.1474915.12171087837586376086@noble.neil.brown.name>
 <586a6402-ae1a-47c5-b054-f02cbd457928@paulmck-laptop>
 <20260508144754.GB2636677@ZenIV>
 <9b90dd3d-e6a0-41a9-8d2d-4faebba6bfad@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9b90dd3d-e6a0-41a9-8d2d-4faebba6bfad@paulmck-laptop>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Fri, May 08, 2026 at 03:03:10PM -0700, Paul E. McKenney wrote:

> On the other hand, one penalty of permitting preemption of tasks holding
> bitlocks is that if some task is preempted holding such a bitlock,
> all attempts to acquire that bitlock will fail until that task gets to
> run again.  And bitlocks don't do anything to identify who is holding
> them, making debugging a bit more challenging.  :-/

Quite.  And considering that this is attempted by anything that hits the same
hash chain while trying to look a pathname component up and not finding it
already in dcache...
