Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A8B730D40C
	for <linux-fsdevel@vger.kernel.org>; Wed, 19 Aug 2026 05:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787115822; cv=pass; b=UgA9u4jM4gZwEBGXTVbLnxPns3IgiB87Il01xpJwmZD90P0Ze3lZZ5Q+DChwSm221NoZXdKINss2Dr6Ox0cTIBNhBhZyPiePVQO8GEqSqScUGP7wB15B0Y5jiBqxwJTrT5zUwR5cqB0b/CRCiYkuMxq1ZtuasZbTkjjrCrdAXLM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787115822; c=relaxed/simple;
	bh=MNn3m2f/M6PWX/mopr33KVN1UaEGPeL/FOg4GPgxkWQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gAb5A22Jx3+4c9nqhuDvzZ3C8mKRXm3F2kqBJM6BC32LfhaWpSyI5WSdkY/6HzX7MamFJhe72gXW4hmc9f2FdDVFPlyYvLMxLFe/PSXQ7RScAAEQAHF9ogui/x82TEKXxFHWsuTQIGTSuMoQK+ouaFV27dsF37Q2PH7bMo6629U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m7G0Ny87; arc=pass smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m7G0Ny87"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-836cde02992so7910327b3.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 18 Aug 2026 22:03:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787115819; cv=none;
        d=google.com; s=arc-20260327;
        b=VnujGohDRlqa8U74LpZocKZ1oK5kJOgVb0Xt9zowWVhW/Oc6zirDbqlSKU+QhGSoiX
         IxW+R2brh1kjVj62pFSwhPB79oaHgKjw+9lzN9zhLzTZnziQ94T35nVxKU90KqB2IHl7
         Nq/FeVKAZmSZ7J/DwEJdpJUtckpRdCpZ8aIA7jAGZyh93ZtAbIgO2+mVGJoW5ahnzmuJ
         bF5yI5xb9EEzttdjnZaSLdmrDezZOdKjHqzXsHM+bl5+mcF5VYt+qM28R7L7CGqpJcnQ
         btjcda5X6y25mN/g6PrtIkSlgmm/WH7JOw2wcnNDdQnfiEoKHApE0GX/gA5qMlg0+/p7
         86gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MNn3m2f/M6PWX/mopr33KVN1UaEGPeL/FOg4GPgxkWQ=;
        fh=6ukLxgrLgO3Z0d1bXFFDPqQ5KKUafBv9XhH1P4X6cQU=;
        b=Yn/zVS6JebkM5sZ4CEm52hca03esG1sbgs+zyGfuN9FoipdcSOcRhF6LLHOZuvuCMk
         A+S8U8EgZFg4gzLHCg/LluPL4hbUdz1y4QNWo3AQwzRv0ewi3peDmWnnSR6v5hVy2eQS
         w3vUAQE8DCrQSM1eiJ+mylTbgLx43depw/B3XIq1fhzMNFOYePy5zMKGE2dwX5yPrrTJ
         WABd9sJFT1QN6n1W2Q5DIyxOnMjKtKhnI/pTHzZ+zlOpQ2GqtB3Qig1tzZ0IIAF1zvtl
         6jA39ZTJZiR+/+5dwB6vMAmAW9AysH9gqv3b9vFzQLu+IvH0yMefBQ8G8CsBiOB73edG
         S0oA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787115819; x=1787720619; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MNn3m2f/M6PWX/mopr33KVN1UaEGPeL/FOg4GPgxkWQ=;
        b=m7G0Ny87MXmtGK6w2SwpGV0/372VUwzjaG6OnRW+8zNAIseqTUOhDwmfuxOHeWsMpo
         ildmaLzjnwGvqFGHhjZyfUNpTDk0zltQSBlwHAUkf95Cinbv6Yt8pRcxDuP4Qkd9Oman
         k1h3lv19HX8Yf64allMAzRt/MaxiOY5Z5f3FteHyDRO1+kEyRCPmCKt4RR0iEKpIo2bv
         OZoAdlO9S+Unf+bWwviuWQOtWUiIdKrsEPkm2SfVWnn/PMxuPYnx1YdhdEbjJZtMvUHQ
         CoPfr5y1V6JdXxMjLSeY4NgvBwMnkIdCe1OMfTHEDO67aZ4c+1eG7d0yqFxlKhKyFKx8
         7wJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787115819; x=1787720619;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MNn3m2f/M6PWX/mopr33KVN1UaEGPeL/FOg4GPgxkWQ=;
        b=XktLzQRC674mW4UxRQCkxYJo2VQTPJdeLTsG7A1gOUHI/AXTAuk/B3LpzppO014QTw
         wLz2SXwQaaFfahsXNpcyh2HgtbyiAsfZOWM+J7iulv+2Ka5471Y3WpkR7P4W5aNIQnSZ
         ImTHrauwT8r3sp8xQSiyVEX0jPY7TQOYMW2qXikxI8b+sPSxtH1geUfbMFZZcsU48tLv
         NCrhSeqomepKs5Kws7TUz35t+aImDs8gJFH3JmJAi26EIZT786inJcyFrKqcePemmMJr
         4Jak8id2R9PBT4QIfYfbBGDQ2RZuN1KMwwhdPezO+5VBbU/QBb/Qz8O4irQJWZTaXD6n
         7MRQ==
X-Forwarded-Encrypted: i=1; AHgh+RrtjowI1SsFGGJIVcoyHYI8pLR04GP/1HpoJxMjx96uuJewKpgXgiZFkQiuqHH1ExQITGOpazzKqukQfjKf@vger.kernel.org
X-Gm-Message-State: AFuF++lJ/y4NfvkDNiOlzISsCb7P4BJ3VWzEDHNwk6+c4cLlnL3s+htw
	FSi61yXb2tUhSZQjocuLqOmLkKkQQpcsdNoi66Jl2E9hTSvDMFdSN/A4WJLhChuZ3tzdbUmSc5R
	rNELvUzsi8HGln5vCoG+gS7xIDATiVeKbvclM
X-Gm-Gg: AR+sD12yBDxtJDgXVN9KnXXFs0Dgsp8sTRxEoYFLsr7HrA29UTO67/NqvLU2mc3Vnx0
	aUWs5ohTo4mOr3pn8d1agFLf0wa8paQFHP4CQF7AJqYaZnAp4jbrFZzYmnzVG/W91+DbchuVnpv
	jEeavf/u0pahTX9uKSxLYXv5CwFBM7vK9gLxhWk9wQu84KMc4iirOl37aXanAng2j93Ra1QeHkc
	2cvgnm/b2d4b4BB7vVbjpISUFfAgrAu1/rkuFx2ZlTxgRcKIywVaAqomtaJC1GVCwHUSksM2dPB
	8FaRpAqtmfKcPMvTbEsSiZ4/u/Te42fa94BaJzg2gA==
X-Received: by 2002:a05:690c:dc8:b0:823:2ad3:d392 with SMTP id
 00721157ae682-844e30c31d4mr9278677b3.31.1787115819464; Tue, 18 Aug 2026
 22:03:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAA5ehdZpfp2w6SWjGm3K7rs-F9Fj-jBY1pRqu_zDbnan2X3U9w@mail.gmail.com>
 <rvcniqbnyaarjm57qxh2qq7mdv27j25cadu5iatynezbdabod3@6aqbsocpuqog> <CAOQ4uxhDFifNsY+cv_+3cc+_NGKj8V_-b-b7usF6J+A+uOtBTQ@mail.gmail.com>
In-Reply-To: <CAOQ4uxhDFifNsY+cv_+3cc+_NGKj8V_-b-b7usF6J+A+uOtBTQ@mail.gmail.com>
From: Harsh Upadhayay <harshupadhayay906@gmail.com>
Date: Wed, 19 Aug 2026 14:03:27 +0900
X-Gm-Features: AcwNN1VQaKs26jWZP7aVFaNlryQTwSLrzjUpwt-Q3KseEcDva-v7HIKez1RzL-s
Message-ID: <CAA5ehdZnbsbbf2BXjOw_PBZ=cSLakrte420=W8zpkg-0Y7Tukw@mail.gmail.com>
Subject: Re: [RFC PATCH] fsnotify: raise default fs.inotify.max_user_instances
 now that memcg accounts for it
To: Amir Goldstein <amir73il@gmail.com>
Cc: Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, longman@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jan and Amir,

Thank you both for the detailed feedback and for explaining the
perspective on keeping the default static. I appreciate the
clarification regarding the risks of unintended DoS and the
architectural considerations for nested environments.

I understand that this is better handled as an administrative
configuration for specific workloads like Kubernetes rather than a
change to the upstream default. I'll drop the proposal.

Best regards,

Harsh

On Wed, Aug 19, 2026 at 5:23=E2=80=AFAM Amir Goldstein <amir73il@gmail.com>=
 wrote:
>
> On Tue, Aug 18, 2026 at 3:47=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
> >
> > Hello!
> >
> > On Wed 12-08-26 20:51:36, Harsh Upadhayay wrote:
> > > I hit this running a 3-node k3s homelab cluster: every container on a
> > > node shares one 128-slot fs.inotify.max_user_instances pool (no user
> > > namespace remapping), kubelet alone was holding 25-40+ instances just
> > > from ConfigMap/Secret volume watching, and the pool emptied under
> > > normal load -- surfaced as an unhelpful, inotify-silent "too many ope=
n
> > > files" in whichever container's turn it was to ask next. Filing as
> > > RFC since I couldn't find prior discussion of raising this default.
> >
> > Not sure what Amir thinks about this but I think default is just a defa=
ult
> > and it is natural it is not good for everybody. I can see how 128 inoti=
fy
> > instances may not be enough for Kubernetes setups but then the answer i=
s
> > for Kubernetes installation to configure maximum inotify instances to a
> > higher value. And as you show below, different container runtimes tune =
the
> > value differently which just proves my point that whatever value we cho=
ose
> > people will need to tune it - which is the point of this limit being tu=
nable
> > after all.
>
> I agree that I don't see a strong enough reason to change an upstream def=
ault
> to another arbitrarily bigger value that could be easily changed by the d=
istro
> or by the kubernetes host.
>
> >
> > So I don't see a strong enough reason to bump up the default limit beca=
use
> > there can be other users for which increased limit could allow a potent=
ial
> > DoS in their setups. The concern isn't as much the memory consumed by
> > inotify instances themselves as you write below but more all the events
> > that can get queued to each instance. OTOH those are accounted to the
> > instance's memcg so your overall argument that in memcg enabled setups =
the
> > limits aren't that much needed is still somewhat valid.
> >
>
> Not only the memory of marks nor events but also processing time and
> arbitrary long delays to other users in the system.
> I'll explain this with an extreme example below...
>
> > > fs.inotify.max_user_instances has been a flat 128 since inotify's
> > > introduction in 2005. That number is not per-container or per-workloa=
d
> > > -- it is a single pool shared by every process running under a given
> > > real UID on the host. On a multi-tenant Linux box, that means every
> > > container's root process shares one 128-slot pool with every other
> > > unremapped container's root, plus the host's own kubelet/containerd
> > > (or equivalent) bookkeeping, since user-namespace UID remapping is
> > > off by default in essentially every mainstream container runtime.
> > >
>
> ...let's do a thought experiment, why stop at one multi-tenant level
> why not nest it several times as userns is designed to do to allow for
> containers inside containers.
>
> In this hypothetical environment I am not sure it makes sense for
> users in container A to pay for the cost of subscribers in nested
> containers B.*.*.
>
> It may make more sense in nested environment for container B to have a
> single group in container B getting the events for all the subscribers in=
 B.*
> and forwarding the events to sub-subscribers and so forth in B.*.*.
>
> Maybe the group in container B does not have inode marks but fs marks
> with bpf inode maps as filter.
>
> IOW, if kubernetes needs to increase max_user_instances for modern day
> workloads - it may do that, but I don't think this design extends well in=
to
> a future of many more containers on the same host.
> Even if userns were used by kubernetes, I am not sure that the current
> publish subscribe model of inode marks would be able to handle thousands
> of userns well.
>
> Thanks,
> Amir.
