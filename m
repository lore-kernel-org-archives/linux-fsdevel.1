Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B528420877;
	Tue,  7 Jul 2026 18:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783450412; cv=none; b=B78qYi1UMiwfjhWGBIF7ctIvhMnb6uR3Zes6IaPzgDGIPAuY1dKCTar09IKs8OpnJ0ZqSOnBJRUoWT86/HbH0LJE4+k1kirXItpHzeQaJqYG7Bfijnn4bI6fj5qZB1hFJtOxQOM47N7rHp7m1jZATjb0Lu/z0ukz/x/FEC1oq40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783450412; c=relaxed/simple;
	bh=DhakKtQ2/I2nlCiLj2KCYK6TDBKIqIPS7WZmebe51PY=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=GPThK7aUzeJZdb+lgxEu0NJ8oWz9W7sXppvypjPAGweHH5ONtIlKoUKQINsCI+O1XixDOf3ZJjFpqIVk6QYaOsJwVk6aaAo51mYdJly1Me1DmH637w5C3RzI6ARc1OdejI7QuG670HXj155214sSU84NF8ygKTUCU0KenqNzZS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J9fKkspC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J9fKkspC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 434871F000E9;
	Tue,  7 Jul 2026 18:53:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783450411;
	bh=pyChHq1ggNdRDcPF8vAKOJh2WfgBck68sOVRmti2nIE=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=J9fKkspChGzsQWCbuM7fCQXHEcZ6c4X4CaX8+LQ8PVWKkWFNVxy6k7XNaYlE5sx95
	 eV4qwdcsOgU2A4pqHZJoiV+3rG877W2RFftnr9L3X5/BQeZ5KAA3wZQwAkkxQPdWqP
	 vYVYpDeHzaOXNrpSmSQLkj9552kWw6SoutuFGS+EW8tT+CPI/Q7BRxZVfga8T1H5xA
	 mTw4v1/+mUShBHULsmtkLzDktfzeYu7wb16kvmuki8UJK7yVbA8lumqAEnxWA3DIGO
	 Q2lKzjWODadmaEtx8Sk2Yv6P7pP128wFbREKvkP7e6b6UswcwFJCp1X72hG+QFu7R/
	 9ZQU1XH8NEw1w==
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] Documentation: remove the requirement for LLM
 attribution
From: Christian Brauner <brauner@kernel.org>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>, 
 Lorenzo Stoakes <ljs@kernel.org>, Boris Burkov <boris@bur.io>, 
 Jeff Layton <jlayton@kernel.org>, Greg KH <gregkh@linuxfoundation.org>, 
 Linus Torvalds <torvalds@linux-foundation.org>, 
 Jonathan Corbet <corbet@lwn.net>, Justin Stitt <justinstitt@google.com>, 
 Carlos Maiolino <cem@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
 Jori Koolstra <jkoolstra@xs4all.nl>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Brian Foster <bfoster@redhat.com>, Christoph Hellwig <hch@infradead.org>, 
 David Disseldorp <ddiss@suse.de>, Mark Brown <broonie@kernel.org>, 
 Jani Nikula <jani.nikula@intel.com>, Jens Axboe <axboe@kernel.dk>, 
 Vlastimil Babka <vbabka@kernel.org>, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>, 
 workflows@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
In-Reply-To: <20260707141803.GA254690@killaraus.ideasonboard.com>
References: <akaWnQ5Pkg_676B-@lucifer>
 <20260702211740.GA639365@zen.localdomain>
 <3f447113-4407-471f-878f-e6d6edafee71@kernel.org>
 <akez23ZhLRSGMFQ1@lucifer>
 <20260703163251.GB3734786@killaraus.ideasonboard.com>
 <e93d28e4-750c-4a4f-8bfd-7a0b404cd05c@kernel.org>
 <akzETpsps4TMfqpC@lucifer>
 <0ba6bf66-e48f-40df-a953-503d317b3dbe@kernel.org>
 <20260707124031.GC211515@killaraus.ideasonboard.com>
 <ebc1f034-7297-459e-975d-5c143567392f@kernel.org>
 <20260707141803.GA254690@killaraus.ideasonboard.com>
Date: Tue, 07 Jul 2026 20:53:23 +0200
Message-Id: <20260707-siebzehn-geleast-gastmahl-4889a8f6b474@brauner>
X-Mailer: b4 0.16-dev-4217c
X-Developer-Signature: v=1; a=openpgp-sha256; l=3216; i=brauner@kernel.org;
 h=from:subject:message-id; bh=DhakKtQ2/I2nlCiLj2KCYK6TDBKIqIPS7WZmebe51PY=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWT5eqtOF4ipfz0z/tHr88a6IUEdnVkmcyfF2gm3hoZtY
 jgSEP6no5SFQYyLQVZMkcWh3SRcbjlPxWajTA2YOaxMIEMYuDgFYCJPFBkZGlfc/tjSeml7l7fy
 0yKOCp4YlbV/Oxa+jHLmPlMW3pb3kuEno8umtKrXPnL8E7xmtVSeZXUpv/2E6/8d2R1OUX8Dkz8
 wAgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

On 2026-07-07 17:18 +0300, Laurent Pinchart wrote:
> On Tue, Jul 07, 2026 at 03:28:49PM +0200, David Hildenbrand (Arm) wrote:
> > On 7/7/26 14:40, Laurent Pinchart wrote:
> > > On Tue, Jul 07, 2026 at 11:49:31AM +0200, David Hildenbrand (Arm) wrote:
> > >> On 7/7/26 11:20, Lorenzo Stoakes wrote:
> > >>>
> > >>> I think the silence suggests nobody :)
> > >>>
> > >>> What we could do is send a patch to simply add a section on adding a comment
> > >>> explaining _what_ used an LLM and strongly suggesting it would be helpful to do
> > >>> so.
> > >>>
> > >>> That should hopefully be uncontroversial, then later (or alongside that?) we
> > >>> could submit an RFC for making the language move to 'you MUST do this', as that
> > >>> will probably be the more controversial bit.
> > >>
> > >> Maybe we should just spell out about which scenario we care about where we really
> > >> expect the disclosure.
> > >>
> > >> Sure, it might be more controversial and we could have that in a separate patch.
> > >>
> > >> I was thinking of the following end result:
> > >>
> > >> diff --git a/Documentation/process/coding-assistants.rst b/Documentation/process/coding-assistants.rst
> > >> index 899f4459c52d2..4c2ab4dfc6da7 100644
> > >> --- a/Documentation/process/coding-assistants.rst
> > >> +++ b/Documentation/process/coding-assistants.rst
> > >> @@ -40,20 +40,37 @@ Attribution
> > >>  ===========
> > >>  
> > >>  When AI tools contribute to kernel development, proper attribution
> > >> -helps track the evolving role of AI in the development process.
> > >> -Contributions should include an Assisted-by tag in the following format::
> > >> +helps track the evolving role of AI in the development process. Further,
> > >> +for reviewers and maintainers it is also crucially important to know how
> > >> +AI tools were used.
> > >>  
> > >> -  Assisted-by: AGENT_NAME:MODEL_VERSION [TOOL1] [TOOL2]
> > >> +Contributions that used AI to generate significant portions of code,
> > >> +comments, or patch descriptions must include an Assisted-by tag in the
> > >> +following format::
> > >>  
> > >> -Where (preferred):
> > >> +  Assisted-by: LLM # brief description of usage
> > >> +
> > >> +Or alternatively::
> > >> +
> > >> +  Assisted-by: AGENT_NAME:MODEL_VERSION # brief description of usage
> > > 
> > > I would like to drop this one. As I understand, several people objected
> > > to including the product name in the git history as it is just free
> > > adverising, and nobody objected to dropping it.
> > 
> > Yeah. I mean, we could go the following direction (dropping the models and
> > encouraging also a description of usage for other tools), but not sure how
> > much pushback we will get:
> 
> I haven't heard anyone involved in this mail thread objecting to the
> concepts you translated into sentences below, so I think it's worth a
> try. Of course there may be objections from people who are not aware of
> this very conversation.

Then someone can basically just merge the original patch I sent since
everyone seems to agree on that front. And then the extension to include
how the LLM was used can be discussed in a separate patch.

