Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B9EB221FB4;
	Fri, 31 Jul 2026 13:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785504373; cv=none; b=MD6DixgJRLj2Hf6amP16TubzxopInQartAOKaXTdeu7Ytldw11bOlwbEN6eBk0T/C85PF9X1sotC22kg9RX+SEp/rZAERo+gYekArmCaEdUGiIRUmHuoQjfsXrdW8EIUwT2ETDT6u6Pi65ZybyGWL238zqmoywek1zka0rq6UVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785504373; c=relaxed/simple;
	bh=Bd0JtjFa8vG1jqHN4xp1I2V3Jiwag/tlNruajdmmBqU=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=u7A48akg07Ln+cHqBroMcm+5REaYlUef51LL7ev2lBjExivWBXPo9KSEunWP8uoVz1934hcscNjK/rBxDxnJ1k2Og51/GLSHECGrDqch9Tzv6A19PusH14vxDgnFUQaZKqu/gcdEOjL/Kf2imAzYPxiMdhIyYzXTtzWD732wrLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TGDaOgvI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TGDaOgvI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 638A41F000E9;
	Fri, 31 Jul 2026 13:26:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785504371;
	bh=SBgZGCElWpwsLuYfDfge2EmLIKqUcS52qQOsu8+TFxM=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=TGDaOgvIv6IiBPcopbayFXng0RJmQlBRpEQ2dR42SFFJbfv0RIMbEwQWBHfzDByLs
	 UO1idgyFctjxANo879go0b8JCB0UvWeIiYCQ0ktLLuV1KD8W+gImhIkivZJZHNlYou
	 2clBCzyjQhfrO08PbFdcM/nk957p78yAv478nybvFAO0JDpgH9PeBNVzm8sHWF2L9J
	 0NVklfvMHdwOXAGj2NHeT4iXNNByDCMY35A8NKVP1Vo0QRSUTC//6j7jOsF/HQg+5Z
	 dmiNGs7a3iZHkAxuKeC0Z92ioqW5M7aETywS6KGOkeFdp4txA4TUi2X68SxCB7TISD
	 +qFrlhGsf4bNQ==
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] xattrat: accept empty O_PATH file descriptors
From: Christian Brauner <brauner@kernel.org>
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <CAHc6FU4719z5crxP-ahSXs2qLachSL9GOiv4kXRZRifNxm-U_A@mail.gmail.com>
References: <20260722151023.1308069-1-agruenba@redhat.com>
 <20260730-armband-reklamieren-heuchelei-6f67abb088de@brauner>
 <CAHc6FU4719z5crxP-ahSXs2qLachSL9GOiv4kXRZRifNxm-U_A@mail.gmail.com>
Date: Fri, 31 Jul 2026 15:26:08 +0200
Message-Id: <20260731-rustikal-revidieren-parolen-02b3e749e9cb@brauner>
X-Mailer: b4 0.16-dev-af865
X-Developer-Signature: v=1; a=openpgp-sha256; l=1030; i=brauner@kernel.org;
 h=from:subject:message-id; bh=Bd0JtjFa8vG1jqHN4xp1I2V3Jiwag/tlNruajdmmBqU=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTlLCravaYo7wpn6O97Vev+L3Sb1GPtectA5vLM/iu63
 NNcu7TaOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACZyVofhf3njW4f418+NGtS+
 5Dzdm/mwWL0oMmtN2CWR3MVc/TlaBxh+Ms7ee85c6EVhTtTW3TZxZy46Ht39mO01Q6C9j/ushen
 67AA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

On 2026-07-30 22:34 +0200, Andreas Gruenbacher wrote:
> On Thu, Jul 30, 2026 at 8:49 PM Christian Brauner <brauner@kernel.org> wrote:
> > On 2026-07-22 17:10 +0200, Andreas Gruenbacher wrote:
> > > Christian,
> > >
> > > here's an updated patch for making the *xattrat() system calls accept
> > > O_PATH file descriptors.
> > >
> > > Compared to the previous version (see the discussion at [*]), this
> > > version adds a fd_maybe_raw cleanup class that uses either fdget() or
> > > fdget_raw() depending on which kinds of file descriptors are acceptable.
> > > That's still a but ugly, but all the alternatives I could come up with
> > > are much worse.
> > >
> > > [*] https://lore.kernel.org/linux-fsdevel/20260701191649.175871-1-agruenba@redhat.com/
> >
> > Thank you. How do you feel about?
> 
> I don't think it's an improvement; see below.

Do you see other users outside of fs/xattr.c that would use this new fd
class. If not it might be useful to just have a local version of this in
fs/xattr.c?

