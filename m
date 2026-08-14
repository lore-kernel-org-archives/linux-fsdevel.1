Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4BCF472F62
	for <linux-fsdevel@vger.kernel.org>; Fri, 14 Aug 2026 15:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786721556; cv=pass; b=LiadoFNQWoUx5JUXkW+C7iKV8JutTtx8zuSRCy6GRpsFVYt9YTixebmw8SsF+CxQmI7VgxoXD9nGBo5njV3qrgGC3QDC7X3BxIbQ7Xe6K6DWRNYvckYs/71yJqV7bVEbWFGETN+TJ9358GR3/p31qmbemlwr0iMrRqmMhJw5T54=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786721556; c=relaxed/simple;
	bh=TK7PQvHRhfO7d69vCikmlkkwgXEXe3Jt7PiHxltn8vg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dAH6LwL9s8XCR3HEdbgGO07Gx1rKYnma61mLsQQjrcJNNgHwhnhF3XPIqTSWhn4JB/Uq3ezy0KQHmuWX+pBWLKp7VGVAhhlCTU0iRtv28wL8EPCdg+JhY6gLlS/hX6Qhdku9r9IjOF8umf69O6JdgEv3zcq9sIc1ULc2eSgpBQ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QWznMTT4; arc=pass smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QWznMTT4"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5aeb59d54b1so1182068e87.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 14 Aug 2026 08:32:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786721553; cv=none;
        d=google.com; s=arc-20260327;
        b=j+6ZNB1npJPaI8ZtXw2QZ5eVadDKVoh7f0K2IHMcBIIDNnEwlfrRDK8rIR6thRkq/M
         9fzLBvU1EsSSSi81FAeSjfONVkDJNFqGsTScC8bpjHcEwO8gqMqXSj6PtQRhqFCbIFE/
         bcbK4cF5fyizqDWBdisuW/JtkrYn9Ij43C6mOKDMLUvk9YywzKc8r3RA/BXinuLsgAFC
         5B2hx18YmcQNYjzVOq1EpKLAcbfBT1pEM8DX+9qwJ/cYMOS09tNNxmhGP9D/W8hLEMBn
         iIkq2gGyZBEcJtlVVVQQ0S0O86tEhddxzR7j1pI/y95RLkNNKcG1PKg+9FlzjYOWfoiu
         oJXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TK7PQvHRhfO7d69vCikmlkkwgXEXe3Jt7PiHxltn8vg=;
        fh=u5O+EXt+Er61J0uIZQsgTTgdFlTdc+U81VjtXWRco+A=;
        b=VG0XgCVVT5Y/g1d7KtlcoFR8os/zYxCbnL1GoFFCvoGSDvZm/UPovG2F65IHi89eN8
         6ZZXrhUM9uCUPhE2znEblxFiFfpZcMEp2CJ1OC8eS1/AxGS9OEJsXS+BMN0cFdhbhTPM
         MmiCivZ3uoAie90XLT7V/VukPCJa0oUxsuPBW3SO73NzA62OPjqLDwbV9xIWzjSJZw/p
         ZDk5P2OzHYZ+jClXJUt4VP1FsnRqGs7eDIC26w7bHiAf5Ot5TKIwZRo8c4IS5Fz93fLY
         dymBphDA7+vr8k/ZCiTmtCSW2eS/nSYUiGAlWHSurXOOiFfP1L5L0IT6IkqacGaN29px
         pd8w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786721553; x=1787326353; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=TK7PQvHRhfO7d69vCikmlkkwgXEXe3Jt7PiHxltn8vg=;
        b=QWznMTT4c3t2Zh+1YWMgRXyJ1gqpDDuql2zC1f86z/QXJ+LDmyoYiCsgrHOWUMtrg6
         bNrJEd3Cx/hUkk0RLs3yPPOdPeX8oi3medfxZQDFon3L4VoD5hAmdBs9iLEjFa9hSRL7
         jnaLRWeWvD58X+4MPJCaZtCwyP3aaV7lddEZRc77gtb2A9q7MpNcyT5Hn/Y4jz6uEV8+
         hfvPGrZm1nrmVn55b02f+uSfFWFWd0fBFA4wYmbMucz1t3T7Sn1GsyCwevbcj5RcvaSm
         2ISKGREqo10apTu42M7VM8zPxXnfHz0fvQEZ1l0So2KL69wy19nmGQ8KLsaYUngr2yg1
         ssAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786721553; x=1787326353;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TK7PQvHRhfO7d69vCikmlkkwgXEXe3Jt7PiHxltn8vg=;
        b=daWr3fYhM3sx55OQlN7Ze+ijbkzq26akrSvQfQIWg9kYcW2Ddyhq25StXN8md7HiuY
         2ZdqgQVHJC0sBg226/RdsUYWzJVAsMlUtblT6G5KJ4FDdK/0oh8ngyp04WOVefSJw2kY
         ZHRFzfxYo2kMlWMO+VyXc/QbZWkHc+9PtLeeHrhxUaLwGe+ifS1klKjlFncV01IfabvG
         mXqI+JuDp2c2t9BK7NE+ZcVxWhVxxvUEQLjNRxjdTL3IPGUxGnR+aYsvHAXFXXngmqoV
         vkrGazsfMMQ1TRDnXpG3LJORwt5EgZrGkYa0+VCbizQAi7h9nz8fgMKSxu3KC2Twkr+y
         KGkw==
X-Forwarded-Encrypted: i=1; AHgh+RqEOvn1u62aLurk570B5n2W2c+wunRwouVAcCiJFkVvJWWim2r6tOR5CImeYOn0AJK381ZJA/fqBL1JRTNt@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4IXnOeXHTq8NSsszVT4MpUlrqtjg+21jJQaOmGIn4rNNZfcrv
	ygIg6tsURxhRs9Wd1VXEZOPOomaBrX9sPg2x/FCbVBC6Xfke/ecR3emt8E10ALBS6nqKvosnOXl
	N2k3QJfRapAX8UPLoXKDhx1a1KmOlPaOTGKK3l1I=
X-Gm-Gg: AR+sD13Pv7Jq/QElBjIpRkW52IpO3YVj8zy0q9tq2XatX45vkpB1sWKsxww5UWxj5is
	gWGfU1/AM8D+W4BktFvYsdCHL8kATjlxiaFleUbL9+6cxhiM0RevPFzoEY0dbDB6m9X/XLP4UdQ
	0Y1gmPCh5l6U6+GOCXztG8Nn3PeKaES4W2IrXr+FRQb7WUFfM8Ruyi40SbgMF9e08lCaQQjFP1h
	s78cD9iRbIgeUbprFZ9xHwkemQIHvt4I0sxFoSaekKX6koYCaJ2uYmG9LVuB172EKqV4XuufLjt
	423ccBZLBYIzMIR1JO9yQzNdGz+yBYJcnPMCsPXk8tJOuFbrWdEF/nMDWe7sWRBIX6SzBnIlbIr
	5jWVSXhwQP2GML2Tv3+uooxaEYsAxozaZwA==
X-Received: by 2002:a05:6512:3b11:b0:5ae:bbe5:2076 with SMTP id
 2adb3069b0e04-5b45914ab46mr1037748e87.52.1786721552817; Fri, 14 Aug 2026
 08:32:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260806170108.2100312-1-daeho43@gmail.com> <ann0OPPglToV_hjs@infradead.org>
 <ff74edb1-43c7-485f-ab78-ec13b500a0bb@acm.org> <CACOAw_zqOS0vHdQV6WoUJyxnDf=kdDAz27pNGDLdQLUdUYOzBQ@mail.gmail.com>
 <an62BorNrc-IX228@infradead.org>
In-Reply-To: <an62BorNrc-IX228@infradead.org>
From: Daeho Jeong <daeho43@gmail.com>
Date: Fri, 14 Aug 2026 08:32:20 -0700
X-Gm-Features: AUfX_mx2Pto06m45d7F2_lptjs17kW4x65ZWOP5JIP6wMXsiPjstrC3FI6rq2kA
Message-ID: <CACOAw_zKnj-o_7OhEWcVGYeFy6m1GM1KCW3hhgBX+O=KTev1jQ@mail.gmail.com>
Subject: Re: [PATCH v2] f2fs: quiesce background threads during system suspend
 using PM notifier
To: Christoph Hellwig <hch@infradead.org>
Cc: Bart Van Assche <bvanassche@acm.org>, linux-kernel@vger.kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com, 
	Daeho Jeong <daehojeong@google.com>, linux-fsdevel@vger.kernel.org, 
	linux-block@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Pavel Machek <pavel@kernel.org>, Len Brown <lenb@kernel.org>, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 13, 2026 at 11:30=E2=80=AFPM Christoph Hellwig <hch@infradead.o=
rg> wrote:
>
> On Mon, Aug 10, 2026 at 09:53:14AM -0700, Daeho Jeong wrote:
> > On Mon, Aug 10, 2026 at 9:34=E2=80=AFAM Bart Van Assche <bvanassche@acm=
.org> wrote:
> > > This information was shared earlier with Daeho
> > > (https://b.corp.google.com/issues/515470309#comment45): [ ... ]
>
> This does not seem to be information available to the public.
>
> > f2fs threads are already freezable: f2fs_gc and f2fs_discard are
> > already registered with set_freezable() and call try_to_freeze().
> > However, a race window exists: a thread checks freezing() (false),
> > calls submit_bio(), and gets trapped inside __bio_queue_enter().
> > Because it gets blocked before reaching try_to_freeze(), it triggers a
> > PM freezer timeout.
>
> This does sound very much like a block layer freezing issue.
>
> > Point taken. Aside from this f2fs patch, I agree that addressing this
> > at the block layer or PM subsystem level would be a much cleaner,
> > system-wide solution.
> > I=E2=80=99ll give more thought to how we can properly solve this race
> > condition for the entire system, and I'll loop in the relevant
> > PM/block maintainers if a viable generic approach emerges.
>
> Thanks, it would be great to fix this properly.

Now, I am considering modifying block/blk-core.c to introduce
freezer-aware error handling in __bio_queue_enter().

The idea is to have __bio_queue_enter() check whether task freezing is
active before it decides to block on mq_freeze_wq.

If the system is in the process of freezing, it would immediately
return an error instead of waiting indefinitely on a frozen pm_wq.

I would greatly appreciate your thoughts on this approach.

Thank you in advance for your time and insights.

>
