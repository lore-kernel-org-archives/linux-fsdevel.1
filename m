Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08F0343F8DE
	for <linux-fsdevel@vger.kernel.org>; Tue, 15 Sep 2026 09:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789464248; cv=none; b=r+7vKp/LBXpFl+x7tvPqp9dBII5o/oTID6z3nKXdQJyxnSsbm3iu41Dhh6XL4H1GdQzPb+CGQY42dEUpysMsNK3mzToMckEhUu0zW7lkB8ynJahjbkv1a3L5bS2bJdVQEJm6oNiBqKYSVYWlqcv3U94gw7qsQAZQujdEwPq+BtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789464248; c=relaxed/simple;
	bh=Xbm7hC2sIniT4/hXQr3ANkVc+vI1px3ZGag7Yl7bcss=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cIsDcaPM6HGcbVNJ/JqsUUTIbZ2iKW7j23nZ+575FNxYrajpyJf1gkvQKJqI9SeMFhGKQhzA2EAyXGw/BihkHHxNg0Yr5G9wjMhaVbdZ4Nee9GwWmobP7SSaQAbzrd+gpvMfFc5XYrQgNuO9tx4XRYB0+wqjhGoB20eATOn2Xao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=crdDg8/K; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="crdDg8/K"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49b912e2406so12226805e9.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Sep 2026 02:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789464244; x=1790069044; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=aLdhT2Q1x0+krLh05Drnda1oX9PUv34jY/LmETe5rwQ=;
        b=crdDg8/KJVXkItsyrr7T2DYuQ82oQhp1H8esuXueNrwy65dwloqlFRim0gwHhmcxls
         FZ2C5sr1NvFi9ZOhJouD8/oe7RhJcohELWooc4SrCkep9sBf4MT2KWfTj8XujpioVPmP
         L0Z2rwmtSgRDgOg9wOZVE9BZA5Hd3Hy4faXblIumemvgeWzKlorGrEh/BrYCi5lJhzDY
         JsiQ2416IcMJY9JaCY8kZMjqpGzPe1gjXbIPxzX10rxhylCJG3+uWtrvYGB/QWDHVj3R
         hAQGjdWi/Q5zm+qeqAfWzivJivRdKXJD4h0cjEMtYh+2Kt5JEsdpqD62uPQaaXcapDge
         bpCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789464244; x=1790069044;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aLdhT2Q1x0+krLh05Drnda1oX9PUv34jY/LmETe5rwQ=;
        b=US0wY45jIkzu/RLgewiw7S8VZN8+DQpIdVr1Gto/VQDN/kFb7n60XzC/840dcgQAyq
         P+5Z8IB3pQn1yUMwsZ+YTwYtrK5Fwtst+jROJo2aCakI9hFI+/CXMEGDF6XzXI65n3IT
         HGhBp3F7p7Zat8K74/0hVWblSR7bAgGLTTBByIVBGfGu7eBtjgZkFY0prI4b1NgyGsAl
         QDeN6L5TSUfN6SYyZOd9Q1QsQ5pg7ec0SSGyxbiBkiNi3eAwApcWo94JlRaRiMz4kYa2
         NFubhJk49JpwMcH4n0wwZEoHgQUlOaXUCL4VUal/3zsC6oIjo3iNxzhzhTQLmSHaygBq
         2NNg==
X-Forwarded-Encrypted: i=1; AKwUvByHKtZeOJnI6BgZSucGYANkhBj3oKt1QMu5OBTA5GWUFf7/6vehA5l3DtiZ1XqTsc4l9M1OnFpQ+YDMJiT/@vger.kernel.org
X-Gm-Message-State: AFuF++mT7bW6aU+D7fyZBXS4Q+/wxLkjNqp/Rc9IheiXSCP5bIxZj38U
	61MzXMzMMCxOJpMjZjkzrE6vwza3CbgozNQxGfD/VRMxnOwyty+664EB
X-Gm-Gg: AYBFou3IYr48HzR51USP3SRWu7A2Hn3UTAbux4f5ADwKPZPWdxVwcNdc8FnVYxeYiFv
	m69pK2raPeFywfcGa7EL8ndgWzbZ69m1sn5YV7maw5LcZDRxH6DKYqHKQBWr9HXNBwFXscZmrAk
	KMc/yaplwXhuuOTqoOaayjihuIGdLC+xz1aEAqW7AItf49ADz+F2pwiuVbFMMJS2OIDhTM1MSqm
	GOy8zHJlQISJDKIQMEqbnmRAgipP9jw3SI1MwWvewU1qx+clZPqjkosexylgFcnWlSBzQDKjinD
	hucqY/xtbA8MvFWDBiuryiJw6eCdzg9T8A2VyVZVXuBPaqism3lh2hkHmNATTaStqhMc55aXi4J
	MpI/4pIY7Msy33RLtZxxNIJKGFCddYpu4vHIXLPqpJwLa0OkL194zvxnTdGBbIfVrmx4Rs6IYzG
	b6/TYSKn14+hLb57MxSRouXx7UB/qLnSRBB4HP3WK43DGmmRTRbJKWb50H5LYnxD0p5hQ/j5NdQ
	wPXK+yUWyqUIENE4E3FOirATPybCjuWy8v4
X-Received: by 2002:a05:600c:c162:b0:49e:65f2:db64 with SMTP id 5b1f17b1804b1-49e7d72b000mr36925425e9.5.1789464243970;
        Tue, 15 Sep 2026 02:24:03 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e7ef9228fsm49333445e9.15.2026.09.15.02.24.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 02:24:03 -0700 (PDT)
Date: Tue, 15 Sep 2026 10:24:01 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Yury Norov <ynorov@nvidia.com>, "Jason A. Donenfeld" <Jason@zx2c4.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Matthew Wilcox
 <willy@infradead.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar
 <mingo@redhat.com>, Will Deacon <will@kernel.org>, Boqun Feng
 <boqun@kernel.org>, Waiman Long <longman@redhat.com>, Dennis Zhou
 <dennis@kernel.org>, Tejun Heo <tj@kernel.org>, Christoph Lameter
 <cl@gentwo.org>, "Paul E. McKenney" <paulmck@kernel.org>, Frederic
 Weisbecker <frederic@kernel.org>, Neeraj Upadhyay
 <neeraj.upadhyay@kernel.org>, Joel Fernandes <joelagnelf@nvidia.com>, Josh
 Triplett <josh@joshtriplett.org>, Uladzislau Rezki <urezki@gmail.com>,
 Steven Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Lai Jiangshan <jiangshanlai@gmail.com>,
 Zqiang <qiang.zhang@linux.dev>, Onur =?UTF-8?B?w5Z6a2Fu?=
 <work@onurozkan.dev>, Kees Cook <kees@kernel.org>, Joel Granados
 <joel.granados@kernel.org>, Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Thomas Gleixner <tglx@kernel.org>, Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann
 <dietmar.eggemann@arm.com>, Ben Segall <bsegall@google.com>, Mel Gorman
 <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, K Prateek
 Nayak <kprateek.nayak@amd.com>, Mike Rapoport <rppt@kernel.org>, "Liam R.
 Howlett" <liam@infradead.org>, Lorenzo Stoakes <ljs@kernel.org>, Vlastimil
 Babka <vbabka@kernel.org>, Jann Horn <jannh@google.com>, Pedro Falcato
 <pfalcato@suse.de>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang
 <jasowangio@gmail.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eugenio
 =?UTF-8?B?UMOpcmV6?= <eperezma@redhat.com>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, Nathan
 Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 wireguard@lists.zx2c4.com, netdev@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, rcu@vger.kernel.org,
 virtualization@lists.linux.dev, linux-rt-devel@lists.linux.dev,
 llvm@lists.linux.dev, Yury Norov <yury.norov@gmail.com>
Subject: Re: [PATCH 00/17] Treewide: enforce static storage for object
 initializers
Message-ID: <20260915102401.3c56aa95@pumpkin>
In-Reply-To: <20260914231418.b15ec01f7225cf460f6e515a@linux-foundation.org>
References: <20260915030336.1192299-1-ynorov@nvidia.com>
	<20260914231418.b15ec01f7225cf460f6e515a@linux-foundation.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 14 Sep 2026 23:14:18 -0700
Andrew Morton <akpm@linux-foundation.org> wrote:

> On Mon, 14 Sep 2026 23:03:18 -0400 Yury Norov <ynorov@nvidia.com> wrote:
> 
> > Declaration macros that statically initialize embedded locks require static
> > storage when lockdep is enabled. Automatic objects must use runtime
> > initialization so lockdep receives a persistent class key.
> > 
> > For automatic local objects, lockdep cannot use the lock address as a persistent
> > class key and reports "INFO: trying to register non-static key" before disabling
> > itself.  
> 
> So why haven't we been buried in reports about this warning coming out?
> 

Are there any code changes outside of testing?

David
