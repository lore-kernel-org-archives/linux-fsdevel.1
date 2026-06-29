Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33AF03BBFDE;
	Mon, 29 Jun 2026 08:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782721375; cv=none; b=cAn7CTTwzze1pcMrKgrVtnJesf0JKGPPtmLO6OllYDTmAJrdV3R0dFZ9XkVkfWvvHNrfYv+sOrbYKzlbGE5+xwRO1g47kEvz21D2BV+/A2T0GJ0VrpUizAvqvnj9TeKjJu80oPCAkYLtr2/me6VFVgzQhXDtiaOqbg+8W937uws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782721375; c=relaxed/simple;
	bh=/qvCfB/+hMAUzRTvNVnPwfLgW8fwdjy78lEtyErvzqI=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=Cw5XiV5+5ZdpH6lYGeHVVz3RyQTIGmqzxLpEePpZu+z7AwJHErwuKeDjzO4X7ybNY0EUVVqzaz1RLXf+b8X31Utqeg1bCbhYIVvnmKkVlpIIfrDOXHJ7tMMtMw50uoUT988mh+jv7C3FMcNCWdug1tKtWTilaHIDRpDTPM4nYz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XivbAz0s; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XivbAz0s"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 739681F000E9;
	Mon, 29 Jun 2026 08:22:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782721374;
	bh=VO/Eqtujp/7YYhCx/kcKYmrsWvAHVn++t8w3Nw2m6SY=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=XivbAz0ssU3xBxeHz99KrnYfHYas/5DiSN2PW/BOqm8/4XmEauHi4ydRgkhrh1yA/
	 bXL4NyUB4YbH6kQJku8f4JV6f6iVEOjQo1l6Wc+q+l3T/mnkji4bmigiQU39mNSGWZ
	 L16g/BWnBADNf230G55BLuiGn6u0K0ei/NY69VivGRF7YbMegpJSIcgBo17lQsvn4+
	 d9dDaI6+3hsqSde7H4JPxYif9lgIxW+UwXazss4NCelkMzdzJyGiSdHv3tX0J9koPR
	 kiiA/e+m+x2AXI7uulaV3HGfJaM8dP/AYJbf1JdzpSJuxNVZsTFV4KVh28fkdJ/RKL
	 3Rf7S7g1QLMJg==
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4 00/31] Introduce SCMI Telemetry FS support
From: Christian Brauner <brauner@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Cristian Marussi <cristian.marussi@arm.com>, 
 Christian Brauner <brauner@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, arm-scmi@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org, 
 sudeep.holla@kernel.org, james.quinlan@broadcom.com, f.fainelli@gmail.com, 
 vincent.guittot@linaro.org, etienne.carriere@st.com, peng.fan@oss.nxp.com, 
 michal.simek@amd.com, d-gole@ti.com, jic23@kernel.org, elif.topuz@arm.com, 
 lukasz.luba@arm.com, philip.radford@arm.com, souvik.chakravarty@arm.com, 
 leitao@kernel.org, kas@kernel.org, puranjay@kernel.org, 
 usama.arif@linux.dev, kernel-team@meta.com
In-Reply-To: <eba18827-5ef5-464c-90f0-2444a996acac@kernel.org>
References: <20260612223802.1337232-1-cristian.marussi@arm.com>
 <20260617-waten-allabendlich-zueinander-93d4b1367b8c@brauner>
 <ajLVW1eHzbGDm4yn@pluto> <29a304f0-1e62-418a-b84f-aabdc4c0de8d@kernel.org>
 <ajR_FBWOoXJKSeoH@pluto> <0025b907-27b9-4a51-b78f-f8ad413644d0@kernel.org>
 <ajU7UqwPZBlwRGkf@pluto> <eba18827-5ef5-464c-90f0-2444a996acac@kernel.org>
Date: Mon, 29 Jun 2026 10:22:46 +0200
Message-Id: <20260629-rangfolge-intellektuell-flagrant-2814268b9d66@brauner>
X-Mailer: b4 0.16-dev-4217c
X-Developer-Signature: v=1; a=openpgp-sha256; l=4629; i=brauner@kernel.org;
 h=from:subject:message-id; bh=/qvCfB/+hMAUzRTvNVnPwfLgW8fwdjy78lEtyErvzqI=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQ5aUdoSJ83+6L6VqSa5cq93csnn+A55qDlWFX7NL/lf
 fjWokKDjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgInwBTL8r8hPX/Mv6+6XNvdn
 LgGJ5wV/rrBX+1oevqyCp2e6z6z8VkaGy69NLvVWMe+6saT6k23GZbaqVc5rXZfWisy+8ra5dfV
 WJgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

> > Thanks a lot, David !
> 
> Let's hope for some guidance regarding the FS side soon.
> 
> But yeah, avoiding the in-kernel FS sounds completely reasonable at this point.

Afaiu, David wanted me to add a few comments on the viability of a
character device for this.

I think you usually have at least the following options:

(1) character device
(2) notification pipe
(3) netlink
(4) well-known AF_UNIX socket

You then need to consider your constraints. David added a few:

(i) root can set properties (enable/disable events)
(ii) non-root can only retrieve properties/events

I assume you mean real root, i.e., root on the host system or more
specifically anyone with CAP_SYS_ADMIN or some other relevant
capability.

This is a rather simple model and gets a lot of head-scratching out of
the way.

But root could also mean "root in a users namespace" which makes this
more complicated as it effectively means that an unprivileged container
would be enable/disable events. This makes sense if there's a subset of
events that naturally lends itself to be charged to a container and that
the container might have a genuine use for.

This touches on another design question which decides how complicated
the whole implementation is going to be: What consumer-producer
relationship does this need?

The process subscribing to the telemetry stream might have exclusive
access. IOW, once you have subscribed to the telemetry stream the
connect is busy and no new subscribers are allowed. This is a very
simple model ofc which has advantages.

On the other end you have the uevent model. Uevents are broadcast to all
subscribers who have a uevent netlink socket open (glossing over some
namespacing details that are irrelevant here).

You need to figure out what you really need here. The choice of
transport also has quality of life implications. 

  (1):
  A character device is somewhat simple but it means it's all inherently
  tied to devtmpfs and namespacing it retroactively is not possible. If
  you ever want to namespace it, i.e., delegate it to unprivileged
  sandboxes, userspace needs to bind-mount the character device into the
  container at container startup or have a mechanism to inject said
  character devices later via the new mount api. It's all possible I'm
  just pointing out that you're tied to a rather rigid kernel object. But
  I think in general it is ok.

  (2):
  A while ago David Howells extended pipes with the concept of a
  watchqueue. A watchqueue is just a pipe with some special properties. It
  can be created by passing O_NOTIFICATION to pipe(2) "meticulously
  undocumented" as Jon would say...) into which the kernel splices small,
  fixed-format notification records:

  int fds[2];
  pipe2(fds, O_NOTIFICATION_PIPE);
  ioctl(fds[0], IOC_WATCH_QUEUE_SET_SIZE, nr_notes);   /* preallocate, 1..512 */
  ioctl(fds[0], IOC_WATCH_QUEUE_SET_FILTER, &filter);  /* optional */
  keyctl(KEYCTL_WATCH_KEY, KEY_SPEC_SESSION_KEYRING, fds[0], 0x01); /* subscribe a source */

  If the ring is full or no free note exists, the record is dropped and
  PIPE_BUF_FLAG_LOSS is set on the last buffer. So consumers always learn
  that they missed something — but not what.

  IOC_WATCH_QUEUE_SET_FILTER takes struct watch_notification_filter with
  up to 16 watch_notification_type_filter entries. With a filter installed
  the default is reject and only the type bit + subtype bit + info match
  let a record through. Passing NULL removes all filters (everything
  passes).

  Kinda like a ringbuffer might be something to consider.
  O_NOTIFICATION_PIPE works from all contexts (hence the preallocation).

  (3):
  No.

  (4):
  A while ago I added the "coredump socket" to the kernel. Basically,
  userspace listens on a well-known AF_UNIX socket address (in this case
  configured via /proc/sys/kernel/core_pattern). The kernel connects to it
  and sends the coredump data via this socket (with some protocol
  negotiation at the beginning).

If you really want to transform the data stream you're receiving into a
FUSE filesystem I think any of the referenced methods is compatible with
that. You just refresh the various files when new events come in and
otherwise show the data that you already have.

In other words, if you allow multiple consumers the following scenario
may happen: Consumer A consumes event E_1 and consumer B consumes E_2,
consumer A now gets E_3. If consumer A is what funnels the data into a
filesystem then consumer A misses data. That might be fine or might not
be.

