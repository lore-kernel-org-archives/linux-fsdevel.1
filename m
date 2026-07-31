Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BC75409285;
	Fri, 31 Jul 2026 17:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785519648; cv=none; b=Osm91P9j/Q3+XKzSBw1ksh8kFsil8zSIgDXO4R+L4jlC1TrudPHi8NE/eTI0VFq5kojNOER8d460P/vEXV+CGlBUKeA/Bs2sSuJCUzRNCwsl1i3bt/C9viOkK0ZqmRP5PoNPU1uNMkPgdr0s+oweTD/ZIID/N0OdChUJkfLSt14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785519648; c=relaxed/simple;
	bh=TGoQMj+p+jdX6QqY32pVurptGVJZn2A+i3IdSmbwLTA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JB+8ujLDL7HpZYnuymz8i9c1tm13QlqKZdRjBc9azWN500doAhyksvENfoX8vJFO7xeg0iiZLby/iUmS2zjdkDDWDhRcbp6M4TMGSxudjfZXUoU4GfIl6oyrZ5hLoRuM9gxl8UuuDlJUOZOWdvhWjIdeGuS7ws4wu/XvGoJ16DU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZyopIUCw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZyopIUCw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB0261F00AC4;
	Fri, 31 Jul 2026 17:40:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785519644;
	bh=xOsZNPiZLrwsRyYuSDTurRc4UKWa981GtnO5vLqQRAw=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=ZyopIUCwH0WFQ8uaT4qz2R5CUC4WY1idI8Yac8qFsF92fbLCW4Y1WP8cO05xCL8dT
	 EJjFmQDbWyLmYgQdtD6DzNWFLuRY6gM8+ygj/VeASmH+o37ETTTyNeI5UQI7ty1dER
	 BIIbEQKVNEbyYqUPcKdaCstSXJ4aeYJ0ov/DmKnbXFoF+6na4FZXwzdQRXrPlIcBGQ
	 Yqb2ZvggASq+lZ/QLDUQ3LHQJHdR5hP47yDZjRP+GCv4nnrlkBGS7MKFgzRkCbuIQj
	 fuvirJyBI78fcH4krHUtBSKTJsf/8MATFUNysQCrbx8EsE5hg++MQ03FEoVeTp0+dO
	 20zSB9v45Yhqw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 97E60CE0E98; Fri, 31 Jul 2026 10:40:44 -0700 (PDT)
Date: Fri, 31 Jul 2026 10:40:44 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	linux-kernel@vger.kernel.org, kernel-team@meta.com,
	Benjamin LaHaise <bcrl@kvack.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	linux-aio@kvack.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RFC 2/9] aio: Use accessor for hrtimer_sleeper ->task
 field
Message-ID: <0f8ddd97-89e1-45c8-a779-e56adcde4098@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <e76a426b-f65c-4357-b263-96506d877136@paulmck-laptop>
 <20260731004019.3530210-2-paulmck@kernel.org>
 <20260731-ritzen-ratgeber-fastnacht-519674d2de1d@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260731-ritzen-ratgeber-fastnacht-519674d2de1d@brauner>

On Fri, Jul 31, 2026 at 02:57:57PM +0200, Christian Brauner wrote:
> On 2026-07-30 17:40 -0700, Paul E. McKenney wrote:
> > The hrtimer_sleeper structure's ->task field is used as a flag to indicate
> > that the associated hrtimer has expired.  This means that the hrtimer
> > handler can be storing to this field while other code is loading from it
> > to check for expiry.  Note that additional races appear for hrtimers that
> > can be restarted, which could be argued to be a user error.  However, that
> > is no reason to let the compiler introduce additional confusion, and to
> > this end, the hrtimer_sleeper_task_get() was introduced, use of which also
> > has the benefit of avoiding open-code access to hrtimer_sleeper innards.
> > 
> > KCSAN located this issue.
> > 
> > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > Cc: Benjamin LaHaise <bcrl@kvack.org>
> > Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> > Cc: Christian Brauner <brauner@kernel.org>
> > Cc: Jan Kara <jack@suse.cz>
> > Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>
> > Cc: Frederic Weisbecker <frederic@kernel.org>
> > Cc: Thomas Gleixner <tglx@kernel.org>
> > Cc: <linux-aio@kvack.org>
> > Cc: <linux-fsdevel@vger.kernel.org>
> > ---
> 
> Reviewed-by: Christian Brauner (Amutable) <brauner@kernel.org>

Thank you both, and I will apply your tags on my next rebase.

							Thanx, Paul
