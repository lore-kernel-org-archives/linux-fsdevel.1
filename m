Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E82B23D648F
	for <linux-fsdevel@vger.kernel.org>; Fri,  8 May 2026 18:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778264773; cv=none; b=hrmeRBSX32T5EmDdtSCm9w1a6Gzuv937epj/y/TX/wxYaZvIYmNP5ddU9DUdSjL2SpSknpnNilaz9gfgiwhCcMTvQJui6ORcVDp4eKy5PeW/iRmZff1BzFE3IumcfGCKo6rTb98zfZB2M82SqDvIGKH1JJh7Amu1Lcddn4UFKKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778264773; c=relaxed/simple;
	bh=gPt2p5mRydIx09aB5eoi5h+EjR87ILB07pmtiyqKD6c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gqfNXhtwHfPQoj8RCQszeEdYkuIEfEMcivYhR7u391l1zt9V0YRxXW86lIa/h2GM+TQZjpKULWlWwuTX85hdYVIWO0yQ/Bc/8lfBEZK0bGN8GbGaMwgOaEB+Z8uCCmpjHiJE9jtlFm9lGn22310fpLuhziUkfqoCUNYQWcAri60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UH89eDTW; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UH89eDTW"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-44c350a5b87so1465221f8f.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 08 May 2026 11:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778264770; x=1778869570; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nadJ4F3fO0o2IbMhIzDipftu6czfRb7SQ9fGD7WtGtQ=;
        b=UH89eDTWQh9OmS5hUj/dgbTfi3H7wYOPLAD09tyOadceQmuQ1jSW8ecpWt6e65vzgO
         dUPuw2rKBsNlxygqwzKdECs3V10qe9a4JTkf9GaWDDLwqBqvoMNLKQ2z3FbIsAL/Xdkv
         h7/yFvPjCarOyc2epdk5HYzixl3aB5dJ7/MAOl6vWwy/FkzEklri+HmlVblgJNeywYs3
         jY4s5DAbrSwYKbkt8b7zGAZBoJzpLJWvDWX8ghQ6HhC4QCi71rcwijca/mxruMoHZWW5
         w3gPGRNJQkqEZa35nbPwNKiM05kM5CZ5Ih7Ano8akSmPY2OogTfMOuflpNXAGNBjiHZS
         1bcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778264770; x=1778869570;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nadJ4F3fO0o2IbMhIzDipftu6czfRb7SQ9fGD7WtGtQ=;
        b=Jz7EI4bT6eeNUGO+u6+6UK2kB6HeKTZJy3UMFPjcY8De0vjysRbWuxM6al8AcDyVgW
         5sUEWnVlk1aJRFFhJVVOFFf0/q1mVb2FHl3VXB0d+D2xDVtxSHKpSyOef2vJ2MY4si4n
         FCksahOggWfBfnkcQmXC1+ok7jt1CXF0E8E2mgR6jbqsSaZ1KQgWdWpmfDDKa82O2wZ1
         dLy0vt71z1FS+s/WgNmxCN+dLTvxS67gLl+nkg5H5kMGbgH4I/yC3medqfwH0g6/ml0V
         xu7BA7rMyal6IiAtn5f4JCby5ITXjUXMrnvwP6MDUX0VrpTrBj2Ja3wIaV2kd2PUMiN9
         2rPw==
X-Forwarded-Encrypted: i=1; AFNElJ8lY2JNkp0fiMDoNSNfrtL6zFBSKrvi0hXy5l4738AnWRm8cYzrTwqqJjKJzfDsmheBBj/l0dap91sUozU9@vger.kernel.org
X-Gm-Message-State: AOJu0YxS/KD87Yq9lujcobwGhdn80y7vd4iYpFmt9QzDHApOVnU/VpPJ
	KR0zdtEPAXgqL593JKjXhErPrEWGHBPkQEKmD4E4+x/BFtPyFqNW7jza
X-Gm-Gg: Acq92OFHQ4+VzneZynE+ibcmw2eP3GQhWwzxQubRq8AoqrOs5imJBpx60awKZegSFzV
	4UhkvtMFOOldtkouVxAgE92Hd8Ex4BsMIKGrbCBBL6QvEaeIpK7PEiyG8GNiyjXPRtJXmN3/2kb
	QHOMecdqlkipqZIjT27YYax1O+mlAH3fPNwASsA9C/Z2tZiRM11ZLHfWRsPKUE4DEWryWQoYTzJ
	FYxTvkOn9DoRXFeRJ09qsVPr1WE6FLisTRwGzdtB5eyDOjhUKGrKuytn6qofOicU9mhvuA1E1Rs
	d0GGPFg9tD90WBTrlSvKq0YlcmZRy5AFse8Ijis6lMp04h3yJnwdRHPYiCOZd2spBAvnK37Wi1a
	JBBSTgsba8ScHVZXCG6GUolreT2ZUETLBtng89SRUF9eQs/OrcGEJmBOfD3yyzvMwVPYvPwoYtl
	E2wqfk8Em/Ad1mHlBjuNx+D8llnGcDEhSmQ/dxqXbyYcCU23PWKTiqTnfelSbn7dQI
X-Received: by 2002:a05:6000:420c:b0:43d:7508:c9c9 with SMTP id ffacd0b85a97d-4515c5752d8mr22366137f8f.27.1778264770073;
        Fri, 08 May 2026 11:26:10 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4548ec6c79fsm6435208f8f.15.2026.05.08.11.26.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 11:26:09 -0700 (PDT)
Date: Fri, 8 May 2026 19:26:06 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: Adrien Reynard <reynard.adrien.08@gmail.com>, "Paul E. McKenney"
 <paulmck@kernel.org>, Frederic Weisbecker <frederic@kernel.org>, Neeraj
 Upadhyay <neeraj.upadhyay@kernel.org>, Joel Fernandes
 <joelagnelf@nvidia.com>, Josh Triplett <josh@joshtriplett.org>, Boqun Feng
 <boqun@kernel.org>, Uladzislau Rezki <urezki@gmail.com>, Steven Rostedt
 <rostedt@goodmis.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>,
 Jonathan Corbet <corbet@lwn.net>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Danilo Krummrich <dakr@kernel.org>, David Howells <dhowells@redhat.com>,
 Paulo Alcantara <pc@manguebit.org>, Masami Hiramatsu <mhiramat@kernel.org>,
 "open list:READ-COPY UPDATE (RCU)" <rcu@vger.kernel.org>, "open
 list:DOCUMENTATION" <linux-doc@vger.kernel.org>, open list
 <linux-kernel@vger.kernel.org>, "open list:DRIVER CORE, KOBJECTS, DEBUGFS
 AND SYSFS" <driver-core@lists.linux.dev>, "open list:FILESYSTEMS [NETFS
 LIBRARY]" <netfs@lists.linux.dev>, "open list:FILESYSTEMS [NETFS LIBRARY]"
 <linux-fsdevel@vger.kernel.org>, "open list:TRACING"
 <linux-trace-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/5] docs: fix repeated word 'that' across documentation
Message-ID: <20260508192606.2423f50e@pumpkin>
In-Reply-To: <1501caea-8cff-4968-aca6-e8d4b20e0e80@linuxfoundation.org>
References: <20260508163759.16231-1-reynard.adrien.08@gmail.com>
	<1501caea-8cff-4968-aca6-e8d4b20e0e80@linuxfoundation.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 8 May 2026 11:15:28 -0600
Shuah Khan <skhan@linuxfoundation.org> wrote:

> On 5/8/26 10:37, Adrien Reynard wrote:
> 
> Missing commit log in all your patches - I don't patch 1/5 in
> my Inbox.
> 
> > Signed-off-by: Adrien Reynard <reynard.adrien.08@gmail.com>
> > ---
> >   Documentation/RCU/rcu.rst                          | 2 +-
> >   Documentation/driver-api/driver-model/overview.rst | 2 +-
> >   Documentation/filesystems/netfs_library.rst        | 2 +-
> >   Documentation/trace/histogram-design.rst           | 2 +-
> >   Documentation/trace/histogram.rst                  | 2 +-
> >   5 files changed, 5 insertions(+), 5 deletions(-)
> > 
> > diff --git a/Documentation/RCU/rcu.rst b/Documentation/RCU/rcu.rst
> > index bf6617b330a7..320ad3292b75 100644
> > --- a/Documentation/RCU/rcu.rst
> > +++ b/Documentation/RCU/rcu.rst
> > @@ -32,7 +32,7 @@ Frequently Asked Questions
> >     Just as with spinlocks, RCU readers are not permitted to
> >     block, switch to user-mode execution, or enter the idle loop.
> >     Therefore, as soon as a CPU is seen passing through any of these
> > -  three states, we know that that CPU has exited any previous RCU
> > +  three states, we know that CPU has exited any previous RCU  
> 
> The original intent might have been to say, "that cpu", so adding
> the missing comma after the first "that" or change "that" to "the"
> would make sense.
...

I don't think adding a comma would be correct.
The clause splits as 'we know that' 'that CPU' and the repeated 'that'
is absolutely correct.
Maybe 'that CPU' could be replaced by 'it'; but it can be difficult to
work out what back references like 'it' refer to.

You can re-order it, as (say):
	Therefore we know that as soon as a CPU is seen passing through any of these
	three states it has exited any previous RCU read-side critical sections.

But just because some grammar book says you shouldn't have repeated words
doesn't mean there aren't exceptions.

The sign writer was doing a new sign for the 'Pig and Whistle'.
Unfortunately the gaps between Pig and and and and and Whistle
ended up visibly different.

-- David


