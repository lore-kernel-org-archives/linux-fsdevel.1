Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4F6F3921F0;
	Tue,  7 Jul 2026 18:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783450521; cv=none; b=g18PgFK4+FPv9jGFCZjrrQFKWL1eArr6L8BmlFlfuQNhWPyfa/RHeS4Q0b153CIWKYXAnaNCnhgkTD1RFJBG6WI3jITVmiLv2bKfmFz0cUtkpBC88oOQEjMh/1mNX5PLDUvSH+cx8Lw6A/p+5w4IA00Yn9eZk3uJC9fYtN71xn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783450521; c=relaxed/simple;
	bh=4ZMiZddo2lXGIwRJHVnBRzW0xsPPw10Zko2u9+cu0q0=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=uvM7K7VV3muL803YEfNNAVXmQVFEy5VtocAkp7sLez0bmTZaM6+JYTwoPqOIExqgPPFC042odjR+orrGE2/eE5tn0l/FBK9IcA6XnC2YWdVAoFJGzJFGES6JQjsR9h3YAq6Zm689AbKqOy4fj3/wAmSKbEE90pcR7gvXPrG8DYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LfARwpne; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LfARwpne"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D63F81F000E9;
	Tue,  7 Jul 2026 18:55:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783450520;
	bh=gU9SlfHafV0koM8UgQLvWQubT0bq2iwUY/wMhv2runA=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=LfARwpneJHTjB5f6jxInWZuJh8Pj5tZ7wQyciGJKFMxFA0lvlRVaJIUrn0Mq10ZtP
	 542ZQUV5qaypSGBEuWPzn/lV1QunSbXo66mFIg0+fCBzOYcLXwO9E4qXk5xw/w3imf
	 X+8G1+SygEWc1bW3nTZ9TgtH7yjyk/ftKahxGV+rtf++kjKFdLzg2GO1fFDXThOaw/
	 WJtMEXtUHuXDGOnkDxOgjAas0uY4QToBCpy6Euxzw/BKUgTdlMNNDvjjZQ3phy5/A9
	 +PzgC0TqDW4b7mGZFyPjbWjEradskfvcqQIwHBE71tDWewQHh31nbCg0/IaNXNRB3B
	 uR1KuVa2VYrZQ==
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
To: Christian Brauner <brauner@kernel.org>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 "David Hildenbrand (Arm)" <david@kernel.org>, 
 Lorenzo Stoakes <ljs@kernel.org>, Boris Burkov <boris@bur.io>, 
 Jeff Layton <jlayton@kernel.org>, Greg KH <gregkh@linuxfoundation.org>, 
 Linus Torvalds <torvalds@linux-foundation.org>, 
 Jonathan Corbet <corbet@lwn.net>, Justin Stitt <justinstitt@google.com>, 
 Carlos Maiolino <cem@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
 Jori Koolstra <jkoolstra@xs4all.nl>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Brian Foster <bfoster@redhat.com>, Christoph Hellwig <hch@infradead.org>, 
 David Disseldorp <ddiss@suse.de>, Mark Brown <broonie@kernel.org>, 
 Jani Nikula <jani.nikula@intel.com>, Jens Axboe <axboe@kernel.dk>, 
 Vlastimil Babka <vbabka@kernel.org>, workflows@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org
In-Reply-To: <20260707-siebzehn-geleast-gastmahl-4889a8f6b474@brauner>
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
 <20260707-siebzehn-geleast-gastmahl-4889a8f6b474@brauner>
Date: Tue, 07 Jul 2026 20:55:13 +0200
Message-Id: <20260707-impfschutz-lerngruppen-klubhaus-7aabcc82f3b4@brauner>
X-Mailer: b4 0.16-dev-4217c
X-Developer-Signature: v=1; a=openpgp-sha256; l=3496; i=brauner@kernel.org;
 h=from:subject:message-id; bh=4ZMiZddo2lXGIwRJHVnBRzW0xsPPw10Zko2u9+cu0q0=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWT5ek9eN+Px4o9MNbpr5J9fZXrhsSzyT1G55lqVevkOP
 yWF3qzHHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABORVGP4w7HpsuieZZPzJsWc
 jrL6/VBWdLHMYs7Jrmu3rHtelfXWfR0jQ4/N2g5egSud8wMW7YvcGFA7MehM31bh1K5qNx5Rdc2
 7TAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

On 2026-07-07 20:53 +0200, Christian Brauner wrote:
> On 2026-07-07 17:18 +0300, Laurent Pinchart wrote:
> > On Tue, Jul 07, 2026 at 03:28:49PM +0200, David Hildenbrand (Arm) wrote:
> > > On 7/7/26 14:40, Laurent Pinchart wrote:
> > > > On Tue, Jul 07, 2026 at 11:49:31AM +0200, David Hildenbrand (Arm) wrote:
> > > >> On 7/7/26 11:20, Lorenzo Stoakes wrote:
> > > >>>
> > > >>> I think the silence suggests nobody :)
> > > >>>
> > > >>> What we could do is send a patch to simply add a section on adding a comment
> > > >>> explaining _what_ used an LLM and strongly suggesting it would be helpful to do
> > > >>> so.
> > > >>>
> > > >>> That should hopefully be uncontroversial, then later (or alongside that?) we
> > > >>> could submit an RFC for making the language move to 'you MUST do this', as that
> > > >>> will probably be the more controversial bit.
> > > >>
> > > >> Maybe we should just spell out about which scenario we care about where we really
> > > >> expect the disclosure.
> > > >>
> > > >> Sure, it might be more controversial and we could have that in a separate patch.
> > > >>
> > > >> I was thinking of the following end result:
> > > >>
> > > >> diff --git a/Documentation/process/coding-assistants.rst b/Documentation/process/coding-assistants.rst
> > > >> index 899f4459c52d2..4c2ab4dfc6da7 100644
> > > >> --- a/Documentation/process/coding-assistants.rst
> > > >> +++ b/Documentation/process/coding-assistants.rst
> > > >> @@ -40,20 +40,37 @@ Attribution
> > > >>  ===========
> > > >>  
> > > >>  When AI tools contribute to kernel development, proper attribution
> > > >> -helps track the evolving role of AI in the development process.
> > > >> -Contributions should include an Assisted-by tag in the following format::
> > > >> +helps track the evolving role of AI in the development process. Further,
> > > >> +for reviewers and maintainers it is also crucially important to know how
> > > >> +AI tools were used.
> > > >>  
> > > >> -  Assisted-by: AGENT_NAME:MODEL_VERSION [TOOL1] [TOOL2]
> > > >> +Contributions that used AI to generate significant portions of code,
> > > >> +comments, or patch descriptions must include an Assisted-by tag in the
> > > >> +following format::
> > > >>  
> > > >> -Where (preferred):
> > > >> +  Assisted-by: LLM # brief description of usage
> > > >> +
> > > >> +Or alternatively::
> > > >> +
> > > >> +  Assisted-by: AGENT_NAME:MODEL_VERSION # brief description of usage
> > > > 
> > > > I would like to drop this one. As I understand, several people objected
> > > > to including the product name in the git history as it is just free
> > > > adverising, and nobody objected to dropping it.
> > > 
> > > Yeah. I mean, we could go the following direction (dropping the models and
> > > encouraging also a description of usage for other tools), but not sure how
> > > much pushback we will get:
> > 
> > I haven't heard anyone involved in this mail thread objecting to the
> > concepts you translated into sentences below, so I think it's worth a
> > try. Of course there may be objections from people who are not aware of
> > this very conversation.
> 
> Then someone can basically just merge the original patch I sent since
> everyone seems to agree on that front. And then the extension to include
> how the LLM was used can be discussed in a separate patch.

https://patch.msgid.link/20260701-work-coding-assistants-v1-1-a20a94d1d606@kernel.org

fwiw

