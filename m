Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77BE12C0268;
	Thu,  2 Jul 2026 08:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782980899; cv=none; b=NN9iFe9mrNmY4UpfOOaMfKDX9xc19T3VzfsMqGyD/cZ5vFxeaoURAEIhDUPGm5dt4noA5Hun9nrrpq625DVNs6XiWZFopScPfQQdr+5vWnuLRapbQYwgLG5ZymF6gkFV10qrrL41+oCzduPS8i8qYmG4QBx9zaicATsD1ClkHYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782980899; c=relaxed/simple;
	bh=8Jjaypqu8RekBvlZLg0vu2Up4Spfh5YTOzvefkq9TLU=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=KA1YOmCm4qrmJCDJcH4MMPXYwx2qCDvmn8gVTg9HxiXxr8H40w1KMwMNUsPU943qlO3ESl23O8i4Fx8eQMeNATmW2aNvl1muWLmnZLa4fRiVdM/iAonW4zqcAohttEqjAI7NDnKJwiuh17mTJ6TTnDoEAQjLZwPxmJRux8v6TSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MeSiIH2V; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MeSiIH2V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCF1F1F000E9;
	Thu,  2 Jul 2026 08:28:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782980898;
	bh=pu9emM89wjPdv27sahxV6Zf17AZnAmlt4GJ1gMEvS/s=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=MeSiIH2VVjHvwBCqMnsrf3K2MXDbgVlRe089tkfJTHTJ2z8Sih0NTNMTkkekmp2W+
	 zdR1ykJPi5UaWChsGWci2iyp6RWZE7Xy8O5ylpUqxod4eo4Z0DjGJGM33aFQ9ZrSqI
	 GFGWcPEHEN/guhU/wVbeUWfDe75PmrCaLpALVpZuHQrqug3Rba3+m/YUD1r7/FUVik
	 r0oR0V1cbKm4qGCVjGIBqmGchVwWBJNjYg5+4Ikb2/D8NLeIa8UbyNTcBJmXJJcstn
	 Z54qmXZFQ/1y0+3x5ktg6ZBx2tRBwygwCLx3e3YbDeC+ydgY/0vAZyeQ+eZLlc5oj5
	 FLdEcDbINSopg==
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH RFC] coding-assistants: simplify attribution
From: Christian Brauner <brauner@kernel.org>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Christian Brauner <brauner@kernel.org>, 
 "David Hildenbrand (Arm)" <david@kernel.org>, 
 Linus Torvalds <torvalds@linux-foundation.org>, 
 Jonathan Corbet <corbet@lwn.net>, Jens Axboe <axboe@kernel.dk>, 
 Jeff Layton <jlayton@kernel.org>, Vlastimil Babka <vbabka@kernel.org>, 
 workflows@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
In-Reply-To: <20260702080840.GG3433808@killaraus.ideasonboard.com>
References: <20260701-work-coding-assistants-v1-1-a20a94d1d606@kernel.org>
 <5e7b9d23-4291-48fb-bdc6-47db82d33c80@kernel.org>
 <20260702-seekrank-stilrichtung-mitentscheiden-69a64ee097ec@brauner>
 <20260702080840.GG3433808@killaraus.ideasonboard.com>
Date: Thu, 02 Jul 2026 10:28:13 +0200
Message-Id: <20260702-bahnen-ertappen-verspannungen-0eaaf1e3f5af@brauner>
X-Mailer: b4 0.16-dev-4217c
X-Developer-Signature: v=1; a=openpgp-sha256; l=3844; i=brauner@kernel.org;
 h=from:subject:message-id; bh=8Jjaypqu8RekBvlZLg0vu2Up4Spfh5YTOzvefkq9TLU=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWS5KcpH3/rPE/Ha7OLCVAW/q5sWy5gvUGf48Kv23yKFb
 Nu7Dy996ShlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZhI+21Ghj3W6ZPUz/96lPvy
 58yzqto61qtu1Kc/dP+6Kd/1m96VlkKGfzqrnmy5V6SjIiQbH7JePjByaWt5KvMjiQoOl+2THpc
 bcQAA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

On 2026-07-02 11:08 +0300, Laurent Pinchart wrote:
> On Thu, Jul 02, 2026 at 09:27:37AM +0200, Christian Brauner wrote:
> > > What would be much more relevant to know is to which degree LLMs were used.
> > > 
> > > Assisted-by: LLM # translate commit message
> > > Assisted-by: LLM # generate some test cases
> > > Assisted-by: LLM # cleanup logic
> > > Assisted-by: LLM # everything and I have no clue what any in here does
> > 
> > I think we should just drop any attribution as a general kernel-wide
> > rule and let subsystems require them as needed. Then you can have all
> > the complexity in mm for this that you think is needed for your
> > workflow to function. This is precisely what the subsystem profiles are
> > for. So maybe just add:
> > 
> > Documentation/process/maintainer-mm.rst
> > 
> > alongside
> > 
> > Documentation/process/maintainer-{tip,netdev,x86}.rst
> > 
> > and lay down the rules that you require for LLM based submissions in
> > whatever detail you need.
> > 
> > I don't see how this additional commentary you want would ever be
> > enforced consistently across the kernel or who would even enforce it. I
> > don't need more beaurocracy to chase after people in my subsystems tbh.
> > 
> > The other thing is that I think this Assisted-by annotation is just
> > noise in the changelog. If you want to know in detail what an LLM was
> > used for when generating the patch it's mostly a signal for how
> > "intense" of a review this will get afaict (already questionable imho
> > but sure that's just something to disagree on).
> > 
> > If the information is mostly useful during review then I still would
> > question why it has to end up in our git logs. It's completely
> > irrelevant information imho.
> 
> Food for thought, the Kubernetes project has published a disclosure
> policy ([1], reported by LWN.net at [2], with a blog post explaininig it
> at [3]). Quoting LWN.net,
> 
> "Of note, the project requires disclosure when AI tools have been used
> to assist in the creation of a contribution but forbids the use of
> listing AI as a co-author or including "assisted-by" or "co-developed"
> trailers to attribute work to an LLM tool."
> 
> I personally don't see a lot of value in the Assisted-by trailer, but I
> would like the submitter to include the information in a place that
> doesn't end up in the git commit history (cover letter or below the ---
> line).

Fwiw, way before k8s I had systemd adopt the following policy:

https://github.com/systemd/systemd/blob/main/docs/CONTRIBUTING.md#policy-on-the-use-of-large-language-models-llms-and-ai-tooling

    We expect everyone contributing to systemd to fully own their
    contribution, be able to reason about it, be able to explain why things
    were done a particular way and act as the full owner of that code. AI
    tools are treated the same as traditional tooling like sed, awk or
    coccinelle.

    For the purpose of this project, AI tools CANNOT be treated as author,
    co-author or be credited in any way that would suggest any ownership
    over the contribution.

    The contributor should have done all the thinking, planning and
    understanding of the changes needed to resolve an issue or implement a
    new feature prior to using automated tooling to perform the grunt work.

    Unguided use of those tools or the inability to prove understanding of
    the code contributed will result in a loss of trust in that contributor
    by project maintainers which can then lead to exclusion from any further
    contribution to the project.

    As with any other submissions, authors are responsible for doing due
    diligence and ensuring their submissions are compatible with the
    project's license as documented in LICENSES/README.md.

