Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A01F6238D42;
	Tue, 10 Feb 2026 01:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770685217; cv=none; b=SFmU1JdMDbZfMghA8x1F40R1Y1dTsTgHcDyTOu7hh6Ogh7rpbY9PbxUzEGnjhM5cMi/DuBaHeT6gT8pMIdLJMAA+6cfDuqQIDTeR4f5SR+EeOFpZY36Gz0fq1cjZzRlLw0hIfhpZFFtgaLwFsKTIv3UGzOmAZsRQSdZ7JZFljXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770685217; c=relaxed/simple;
	bh=WkA9rpnxyS49CHEutIsPUFaQZOTG1RB9isrFStJBg18=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NRey1g22iggGOuVbQuc71tRGhmg8tlv8d4fwqjbwSM8mRSIteN/8SfBPhrDj54ZVvbfiRqChNir2PxS03/9wy6Ix1PJCaXx5nI0/8p6b2M54pHTZYH8NUalsHOTyyqB88GsSx5djhhVFkKYXWbF7FHNp+XzJ93pqR6Vx6gkHWw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=evilplan.org; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=fail (0-bit key) header.d=infradead.org header.i=@infradead.org header.b=vOQk5Dcu reason="key not found in DNS"; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=evilplan.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=infradead.org header.i=@infradead.org header.b="vOQk5Dcu"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=zeniv-20220401; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
	bh=t2wxURkDpz9U+/rpPtgCv5zMK1yxCxCSnvISpzbhEd8=; b=vOQk5Dcu+TGTEAWGAnRdn/VRNX
	fHOJIFDxTLhfuWrXuRwW8A6BnpGphvkeqIsMSIvgly2fCkcJ/4TGh/3ayCWwm7vQ8jfZrSNw9KEPz
	z0G2XGD9aHCb6/gs4OexeEBM67ToIMMIcfv9FdXaiEf5lysoueXjmZ0NwDK0Ml+O1Ob8+Cir4LfJS
	q5AG5UtDSVQafekg56Ywad4g2WQpVMA5hj/XRxtnsiAqBjwOpfnwHIyQ1FwQGnu0Cv8u1BgqQgd21
	wlu6cZc8t6wkQtwgRB7lTJ1tZyGeG6KHRihmUsxkquTaoJCAgVSqeQS75X20ltiZkDPzB7TC70xxQ
	RQr/rXcQ==;
Received: from jlbec by zeniv.linux.org.uk with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1vpc8u-00000002Fw8-2vsB;
	Tue, 10 Feb 2026 01:02:16 +0000
Date: Mon, 9 Feb 2026 17:00:01 -0800
From: Joel Becker <jlbec@evilplan.org>
To: Breno Leitao <leitao@debian.org>
Cc: Andreas Hindborg <a.hindborg@kernel.org>,
	Matthew Wood <thepacketgeek@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org, hch@infradead.org,
	linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org,
	gustavold@gmail.com, asantostc@gmail.com, calvin@wbinvd.org,
	kernel-team@meta.com
Subject: Re: [PATCH RFC 0/2] configfs: enable kernel-space item registration
Message-ID: <aYqDEW1sSnaq26GK@google.com>
Mail-Followup-To: Breno Leitao <leitao@debian.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Matthew Wood <thepacketgeek@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org, hch@infradead.org,
	linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org,
	gustavold@gmail.com, asantostc@gmail.com, calvin@wbinvd.org,
	kernel-team@meta.com
References: <fdieWSRrkaRJDRuUJYwp6EBe1NodHTz3PpVgkS662Ja0JcX3vfDbNo_bs1BM7zIkVsHmxHjeDi6jmq4sPKOCIw==@protonmail.internalid>
 <20251202-configfs_netcon-v1-0-b4738ead8ee8@debian.org>
 <878qfgx25r.fsf@t14s.mail-host-address-is-not-set>
 <-6hh70JX5nq4ruTMbNQPMoUi6wz8vmM2MQxqB3VNK3Zt97c-oxWOo3y0cQ7_h6BSfcp78fR9GmzxcTQb_WB-XA==@protonmail.internalid>
 <ineirxyguevlbqe7j4qpkcooqstpl5ogvzhg2bqutkic4lxwu5@vgtygbngs242>
 <875xakwwvz.fsf@t14s.mail-host-address-is-not-set>
 <C6V44SxiJH8NxRosmbshR-sfcBisrA5yWQpDmfQXe5vOX3uI6SM-r7wwUr7WxfPMS5ETUQ9GYDlptRs911A_Qg==@protonmail.internalid>
 <aYTWbElo_U_neJZi@deathstar>
 <87qzquuqsx.fsf@t14s.mail-host-address-is-not-set>
 <aYnnHJ2TQEcD_xMS@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aYnnHJ2TQEcD_xMS@gmail.com>
X-Burt-Line: Trees are cool.
X-Red-Smith: Ninety feet between bases is perhaps as close as man has ever
 come to perfection.
Sender: Joel Becker <jlbec@ftp.linux.org.uk>

On Mon, Feb 09, 2026 at 05:56:34AM -0800, Breno Leitao wrote:
> On Mon, Feb 09, 2026 at 11:58:22AM +0100, Andreas Hindborg wrote:
> > Perhaps we should discuss this at a venue where we can get some more
> > people together? LPC or LSF maybe?
> 
> Certainly, I agree. I’ve submitted my subscription to LSFMMBPF with the main
> goal to discuss this topic. I wasn’t planning to present it this, given it was
> a "overkill"?, but I’m happy to do so if that is the right direction.

Sadly, I won't be able to make LSF or similar.  I do have strong
opinions on this (you can find previous threads where Breno and I
discussed the topic).

I think the usability issue is real.  It's worth talking about how to
close the experience gap.  But like Andreas, I also have a strong
concern about changing the fundamental paradigm of configfs.  Open it up
to solve this one "can't do it any other way" case, and watch all the
"we can do it with userspace, but it's simpler to just code it with this
kernel hook" followers appear.

Since the problem is entirely about pre-userspace timing, perhaps that's
where we can focus?  Could this be done in initfs?  I suspect for
netconsole that initfs is too late; command line arguments are
necessary.  What about, rather than create a generic "kernelspace API
for configfs item creation" could we just write a "command line
arguments that represent what a userspace mkdir would do" hook?  This
could be private to configfs, and maybe even limited to when in the
kernel startup it can be used.

I can imagine a netconsole argument like:

  linux netconsole=4444@10.0.0.1/eth1,9353@10.0.0.2

could become a general form like:

  linux configfs=netconsole/newtarget:local_port=4444&local_ip=10.0.0.1&dev_name=eth1&remote_port=9353&remote_ip=10.0.0.2

A legacy driver like netconsole could even take its legacy string and
convert it to the configfs form and pass it along, as long as its within
the module_init/boot scope.

Just a thought.  I haven't evaluated the practicalities.

-- 

"War doesn't determine who's right; war determines who's left."

			http://www.jlbec.org/
			jlbec@evilplan.org
