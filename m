Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64D4033E346;
	Fri,  3 Jul 2026 07:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783063819; cv=none; b=ftviftyWIIvcXRk1eU9vym9ZBEMYGpXnHFl7b5+ge2EO/lp7QStlN38pBxJxSlGHK97R1FWGA465NDOaKwxAIyTh+KgPEgTFGPNHYXf+BZXU7I5RoTpKpsW0PtP+j0WqTEZ/bb0O0EQP6jOFFcot1Ta9M7NCjFAeJ1fPPTn8yYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783063819; c=relaxed/simple;
	bh=sV8K8pz5m41+kXej+oXIAb4uthJkxpay7Uxl+GOr7cw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PCxQ/jD3/r4ql0bftGX446hTvc70MQ4LnMce5w6DEo/fJvwjn+7XCxo9eQKju9j+pxarvoX8yHJoxCZxizw0xuuLG7JMtihiZMgnGmaym5nv0j+zb/0FLv91L8q2rOd9NSivaMZdNcan6yGKFCRwxnALonU/qakbFopANIKuFyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=T2Eesty9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="T2Eesty9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 399BA1F000E9;
	Fri,  3 Jul 2026 07:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783063817;
	bh=0UkMf5KpFWLG8dCjlwX6LdkEpqXS0Grj+yFQmCspZos=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=T2Eesty9cDIysvgwI8C9l4up6gr4GCOCjGwtmoRLzTJpxMQTWFQv3nD8cuGSWv1iy
	 /RLtDXnNq+CAQHAyZ/J0ZTJHA0BHJ/0F0P40OmICWwcrR6HlZhXu3N+zzsto72AHNZ
	 lrDoE+ieROWSCFdSomu19tVBDYOCfkDkMSpVjlrU=
Date: Fri, 3 Jul 2026 09:30:28 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jeff Layton <jlayton@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Justin Stitt <justinstitt@google.com>,
	Lorenzo Stoakes <ljs@kernel.org>, Carlos Maiolino <cem@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Jori Koolstra <jkoolstra@xs4all.nl>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Brian Foster <bfoster@redhat.com>,
	Christoph Hellwig <hch@infradead.org>,
	David Disseldorp <ddiss@suse.de>, Mark Brown <broonie@kernel.org>,
	Jani Nikula <jani.nikula@intel.com>, Jens Axboe <axboe@kernel.dk>,
	Vlastimil Babka <vbabka@kernel.org>,
	"Christian Brauner (Amutable)" <brauner@kernel.org>,
	workflows@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] Documentation: remove the requirement for LLM attribution
Message-ID: <2026070343-copied-quarters-1e2a@gregkh>
References: <20260702-aidoc-v1-1-735572dfb995@kernel.org>
 <2026070224-unholy-commode-cf45@gregkh>
 <2114bb79bb5b6e5584a8236de3590e2f4bf0899f.camel@kernel.org>
 <20260702161330.GH3534761@killaraus.ideasonboard.com>
 <2026070227-payroll-eradicate-8f66@gregkh>
 <20260702163215.GC3559965@killaraus.ideasonboard.com>
 <2026070350-drown-untreated-5835@gregkh>
 <a095d9b4-f774-47d9-affd-d519d8acfb34@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a095d9b4-f774-47d9-affd-d519d8acfb34@kernel.org>

On Fri, Jul 03, 2026 at 09:23:11AM +0200, David Hildenbrand (Arm) wrote:
> On 7/3/26 08:37, Greg KH wrote:
> > On Thu, Jul 02, 2026 at 07:32:15PM +0300, Laurent Pinchart wrote:
> >> On Thu, Jul 02, 2026 at 06:19:15PM +0200, Greg KH wrote:
> >>>
> >>> Same here.  I don't care about stats, I care about "how do I review this
> >>> patch" and this gives me that signal that I need if faced with a
> >>> llm-helped patch.
> >>>
> >>> So it needs to stay please.
> >>
> >> There's the free advertising issue we still need to address. Would the
> >> proposed "Assisted-by: LLM" tag to replace product names be an
> >> acceptable option for you ?
> > 
> > I really don't care what the tag says,
> 
> Well, while you don't care, the current policy implies that:
> 
> "
> Assisted-by: AGENT_NAME:MODEL_VERSION
> ...
> ``MODEL_VERSION`` is the specific model version used
> "
> 
> So clarifying there that a "Assisted-by: LLM" is also good enough would make
> sense if we agree on that.

If we all agree on that, I'm saying that _I_ don't care, but others
might.

For me, the info after "Assisted-by:" doesn't matter, it's the first
part.

> I'll also note, that the "*should* include an Assisted-by tag" is pretty weak,
> as someone who worked on specs before.
> 
> My kids should clean up their room; doesn't work.

But, if you notice that your kids didn't clean up their room, and you
had told them to, you can then talk to them about doing it properly
based on what they are supposed to be doing.

That's the point here.

thanks,

greg k-h
