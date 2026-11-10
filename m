Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794330249;
	b=hNIEp8SogJhfhqP5RZFtVKrLUGTPABAxLOyQeQRYqu+aI0B3Gfv5kPmAImZQY7qYZwe8
	 OhDalhzbJhQU3tPNvMOkxHpFoCmAB9ZfN82MCR0Ub4kF/sFspABSNWSiKfAYi/JifFsiM
	 nJsT8FAbRtBRUHmrTSG9iQqBV8mCvEIHY1UILtGi6AfA3drqe/GFcShXo0B6bsflqtAkQ
	 zwoly9Qb5BySBDfxlYkBm0Cm/ZYMoheWeSnud2Z2kylOBAsT3CxaFID7ZAMRbhVFI2YBn
	 p7GgvtozQlEzIAlp3vvUr00oRWHSyMSFbYrSSDxemALUkKywFcPLD8KS5Ny2IPF4oMA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794330249;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=Gq0M0cu2Lo2dpH/31tGMSg+0YblrzrHJ9B+jvPcEV1o=;
	b=M5PbOZr9MFczPb7B+pvdFwUqAdILMlf3xxygzgBDkrLVhJ6Y5QXPUu2JtqV7gZCB9CYS
	 kDxreTkPMC2M36828oHPX15yt4ghTOKqqtuCte2jTcsiWNocKxvVziunJfz5T41+obzhA
	 L0VNvIVpgrhYzkgakzxZTNv3KJQgDfU7BogHShDF9774TTihYJACbcTVUIBs1yYq+9fKd
	 WA2NgBnEWVDj5sPVrbYuVDlfgsmFjrivGKql9NHUiK2/FxJMGAUSabwmKv3E5S0POc8Y4
	 L7/nvgCQDkCj35LHryg5A+AHRnKbHEJMJpdSrKliJMnoqWNHciv4C6t2RCwd5wA06eA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G1cgX7Ni;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3772606A321;
	Tue, 10 Nov 2026 17:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G1cgX7Ni
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14C4E1F0089F;
	Tue, 10 Nov 2026 17:04:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794330248;
	bh=Gq0M0cu2Lo2dpH/31tGMSg+0YblrzrHJ9B+jvPcEV1o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=G1cgX7NiXhXz1FiR4I3hiMIl8Zg3MlXjsdc+UHxBoZ71sJhJIeejhkHzBEscFHpyO
	 ehXeoroAKlW9RB8Utvb0oBHHg2hzsHAfyeyVaqKEmnfTPmHMHRZD/yRcg1JToi9PnI
	 Usds/guZ1hvt6T7e7+LeCxWlfnMFCQtCj/iYy2CUwcI+f3EovAcj1CG2UzgThf2hUB
	 68e+msgJJMgWlmk/1q2VsYMk7RuIEE8R4pA1OBmg0bprVRM3YqNZ4kRKHjto6nBwXt
	 jbRyD0WTFLWru0NVnW6DKCgJwtUDRcEGjIf8dcgg/MaEWx11DbfdfUHVEBtgGWJCxe
	 u/h8Pe+zuP63w==
Date: Tue, 10 Nov 2026 18:04:03 +0100
From: Christian Brauner <brauner@kernel.org>
To: Bence =?utf-8?B?Q3PDs2vDoXM=?= <bence.csokas@arm.com>, 
	Jan Kara <jack@suse.cz>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v3 0/2] Add scope-based cleanup capability to eventfd_ctx
Message-ID: <20261110-spekulant-erledigen-allumfassend-280fdca625e2@brauner>
References: <20261027-efd-autofree-v3-0-caa2442e1beb@arm.com>
 <20261106-hinein-lagebericht-abbezahlen-cb826d68d175@brauner>
 <bba04255-5dee-4dd2-a877-5e169edceadc@arm.com>
 <sp6gvawt6petvrlky7g6pqaqsp3jwouu6ixarevis5m5vd7fwe@xjxeakzi3nn3>
 <803191ed-6597-4b8d-af7d-812b1b494fee@arm.com>
 <boyk6gdk2qmgj4fxhbluqbtcbhqkgnyiq36hurhomfib6vrogw@tjgi2oxtbvmd>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <boyk6gdk2qmgj4fxhbluqbtcbhqkgnyiq36hurhomfib6vrogw@tjgi2oxtbvmd>

On Fri, Nov 06, 2026 at 04:02:00PM +0100, Jan Kara wrote:
> Well, the change is kind of "meh, I don't care much" for me. So I guess if
> you include some conversion that actually makes code simpler, I guess
> Christian might be open to merging this.

No, I agree with you. I think if at all it should go together with a
conversion that actually gets rid of a goto mess, e.g.
mshv_irqfd_assign() or sm.

-- 
