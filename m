Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4BCE2EAD15
	for <linux-fsdevel@vger.kernel.org>; Mon, 25 May 2026 12:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779713581; cv=pass; b=U91ni2oCClZORU9nA4yWpesjRV3llResHSEHfmjQgIahxxf7NoL3i4EffF2NrxVB9KP/nWbsb7ZKsTh0pdsi2vEGqbK9p7m7OPPtaSQnbAo1+sPxWk2Vil0nhb4fNY6B/imS2W6zQsfloJDhlA1itq/FtmKD3yZQwajLAJZVX4E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779713581; c=relaxed/simple;
	bh=2JBmvuPMbokKpDBy3vFjCkDfkQ3kTfho8REqGhIiF5w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aAswGPmc4zo92CsWBzjtc5OPcEM5Xkuoj7FqLp8PV41J1fjcPRLk13wWMCxl/XMjcuvd5nuBC53gt0HFhUwONIzAp7WywBeLkc852P6qM/A87kO7WHr3XNYrpzbExusX3TM0DnnwflFy1HV6NQqGgx8cpYq8SLn9n4LkGkyA8RU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gwQ9Shz+; arc=pass smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gwQ9Shz+"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6877c719cb0so7364622a12.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 25 May 2026 05:52:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779713578; cv=none;
        d=google.com; s=arc-20240605;
        b=QbmFHQ5tThh8Je1e2NGaLVHop7mTeetUPQo0Ta1AFaERfV/Tw20gPElIwC1JCRNf+L
         Ixf7tQZx8JYJ9iNgOkmr9OcWwLgpU5h9hhfIK8MIjVL3T6gQTURQVYhKtG+LXOuc1pGi
         mfqfBHryqMTTgig/onuPIswx5TFLKtEP1rExi7czDbrV7rJebJ4YHVabEwOJaBtumBcv
         FDOF9ATSxDOIL0MqWNocXMGJuikQSHiV45zA0KJQ840IFkfaPQiwdWDgnsElasidHOvN
         OXj3XEmY9wdH7k4YEy0Bl7FV2qy6w6yCO2wfhu0NF0FNpC/EDKlK8zisP0Byze79urTo
         umlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6nUyf0bHWn9hG5IDPRa3jM4VPgnPoldfdl/9Nznoc+I=;
        fh=kjP0M+zTVQ5ElPGsdhP5Rux8snqdo/Eav5p1CbMlioo=;
        b=FAVG5V0+SmLPeCTRG2qr0Imk4lPJV8lnnXqjIvCXvCJ3w+QN2g9p1EoGzRaj6gC/b1
         tmrP+Gic1AAIexfjcHzoPOD5ycUYw3SbSQFrNzFh6RfyW8CteR7QbhWKJ8kJtGE4tVhR
         +ma5G9oE/knK7y0E6+aClvqYUMhYjEIccCW0jVNKYOULwMrcCNSZfc/NCXfDTkkVRDIK
         lKOO0nJ/LnEgAWu+1vlon7eCIjHFk7xjssnQHvqa4ZLUAvZFGsW37CN8gWC9PRr3ZkeC
         EbOn9bij30g4//myehzatY39fMw1qHayDQp1wYpPoen4hz5xTxcZEgN1g/L4QMSlKMCV
         vRxw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779713578; x=1780318378; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6nUyf0bHWn9hG5IDPRa3jM4VPgnPoldfdl/9Nznoc+I=;
        b=gwQ9Shz+5Av0O6o8UHadGpu0XVspNw3X6gN4AcLozeQtd9esD/avSa6WIQalRvSMLL
         an+oZL5PWvcMFS+z20qDE9GOHkQ5blWtUBMHrSDio7xaYyQGkVJKpRl0FibIzq6DNt+L
         pU5xARUxW44CEBXLUyoK5ji9lEkaAMpncauR3wyjHvS10b1gu7ndLwZiW98Q0F8IP1fu
         xApeE8wGSYoBoJ68spYC7RFwAIHNbtta8hR9drJaJUgM9Qn4zvjK9lnI4LV5oYaaamsI
         +3j9+0wuiH+hJIX2xQ4zsvUxaz/fMylMXu0Vz8KIbfdK36fKZihUC1JbuJVarJF7Xf0y
         N03Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779713578; x=1780318378;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6nUyf0bHWn9hG5IDPRa3jM4VPgnPoldfdl/9Nznoc+I=;
        b=GILmxY9ZJsJAk/p+kaL0RAqW1ucr8FaoNwp2HltvobsNiXLWEwxuH2h5Ur5hu5XnDD
         1GSI/OEsss/zRc3UMGPFtpePIBw7UKeZuuacxNOzTsn5rk+AdQOLfOG10JjqQmRMartf
         LJpGTxLBpOi1rCiZOaUaLQmKbBjf9eM/iQLzk7gEunv5omUlKrdjjomtJisBHaoCkfji
         oVEQ9BTSx5Q59Z88+pqalJ/ce9A8khRQJ2LpYNZtYrIKxr1j7x/toO9H/LVQ2cwBKrP5
         mW3JVDyF8EkHjZT/8BKgNiaEY2dskenmY92gzi7x+Oa2lxeLAt/cX99kl4uPacpQ3s3X
         ygcQ==
X-Forwarded-Encrypted: i=1; AFNElJ+b5gBhMbBymFO/+JJATFPABFGGZ7Vylbi865EwgHR/LQHYqUEIBNBgWd74PrGDtR3T/tEUVDRD7Lf3oeYA@vger.kernel.org
X-Gm-Message-State: AOJu0YzMda1m3dbdXOHtnqMX3i93oBRMOLvyYoivh/dS5gMYpI1SSYH+
	z31aCmBbvu6nvywkVJRrY40hTYMwLODNYHJ+gpZ5l0BjcnesVdbybTSfintFEjTKas5lHe723Eu
	ZbKGiEi6trIyle91D+8X+LEjGUWQwe1c=
X-Gm-Gg: Acq92OFfebiiC+tgxYe/MQcLxol9y12J4Wp/8LfvmWNOO2jUPyZQdZFv/lNKAb+elZB
	HL/Z/YokYa8MhNurI23lQn++xjtT0fbRMQf5RrWg+OpgEo3Bz9xBzwLwjRQVQA83stMIPavloBr
	TnZe1CRbro7SXxrZ0SgDn5V4Uii84f7sncrukC6zqCpiq8TVvgFXurHAXNIElUrWOnzrteahZSx
	E55Pv7Io/zj7jU+ZFeNziJXzBhGB7Nr/ugYV1KKx/UFKKIGZID8P/SuC7ow9zBOh1O7mZL2qlNq
	72NM2GJDXjH9RrWjwV7pm/+Io3TrcuKL1NiZug==
X-Received: by 2002:a17:907:c706:b0:bd2:633a:c8bb with SMTP id
 a640c23a62f3a-bdd263c9447mr794029466b.22.1779713578127; Mon, 25 May 2026
 05:52:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260424170503.2096847-1-amir73il@gmail.com> <20260424170503.2096847-8-amir73il@gmail.com>
 <ulal5iiolonkeccun5lyzkuf73odidgbkmabzupbwtawwjhhlz@tneaqqtlody6>
In-Reply-To: <ulal5iiolonkeccun5lyzkuf73odidgbkmabzupbwtawwjhhlz@tneaqqtlody6>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 25 May 2026 14:52:46 +0200
X-Gm-Features: AVHnY4KE_c5S2edwKBmboziClmtfsX2q69ywM6y5JhgofqNFgFsi65iq224hzns
Message-ID: <CAOQ4uxjO+Q_Z0OF4XquO7o4GVF2b3akRDrLYadtUNpZzi8nEsQ@mail.gmail.com>
Subject: Re: [PATCH v2 07/10] fanotify: gate fs events checks in
 fanotify_mark() by group type
To: Jan Kara <jack@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 25, 2026 at 1:28=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
>
> On Fri 24-04-26 19:05:00, Amir Goldstein wrote:
> > fanotify_mark() has plenty of checks on the event mask.
> > The event mask bits that correspond to filesystem watchers are only
> > meaningful in the context of filesystem group type.
> >
> > Hence, before checking if event is a specific event (e.g. FAN_FS_ERROR)
> > need to check that the group type as well (e.g. filesystem).
> >
> > Add helpers fanotify_test_{fs,ns}_watcher_event() and use them instead
> > of checking the event mask directly.
> >
> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
>
> I was looking into this and thinking about it for some time and I have on=
e
> brainstorming suggestion:
>
> > +static inline bool fanotify_test_fs_watcher_event(struct fsnotify_grou=
p *group,
> > +                                               u32 mask, u32 test_mask=
)
> > +{
> > +     return fsnotify_is_fs_watcher(group) && (mask & test_mask);
> > +}
> > +
> > +static inline bool fanotify_test_ns_watcher_event(struct fsnotify_grou=
p *group,
> > +                                               u32 mask, u32 test_mask=
)
> > +{
> > +     return fsnotify_is_ns_watcher(group) && (mask & test_mask);
> > +}
>
> These helpers look a bit cumbersome (having to manually select the right
> one, there's no safety if you accidentally pick the wrong helper, you nee=
d
> to pass the group as well, ...). So I was thinking about the following: I=
n
> fanotify uAPI the mask is actually 64-bit. What if we carve out some bits
> from the upper word (8?) and store the group type there? Either we can do
> this type-encoding only internaly once we receive the mask from userspace
> or we could even have the encoding in uAPI constants as well - which woul=
d
> provide additional uAPI constant type safety (we'd have to special-case
> FAN_MNT_ATTACH & FAN_MNT_DETACH in that case but that should be doable,
> since they are not widely used yet we could maybe even eventually depreca=
te
> the old values).
>
> Anyway, once we have the type encoded in the 64-bit mask we can easily
> compare, mask, combine, ... these with some helper functions without havi=
ng
> to check the group all the time and having to select different helper
> function based on event type. We are not very consistent with passing
> 64-bit mask everywhere since the fsnotify core has only 32-bit mask and s=
o
> far we use only the lower 32-bits in fanotify as well so that would need =
to
> be fixed.  Also once we store the mask into the mark, it would be squashe=
d
> down to 32 bits but I think that's fine.
>
> What do you think about it? Do you find this worth it? What's your opinio=
n
> on having the type encoded already in uAPI constants?

My opinion is that I had already started playing with that, see:

https://github.com/amir73il/linux/commits/fanotify_event_type-wip

--- a/include/linux/fsnotify_backend.h
+++ b/include/linux/fsnotify_backend.h
@@ -78,8 +78,10 @@

 /* 64bit kernel internal event hint flags */
 #define FS_EVENT_IS_PERM       BIT_ULL(33)     /* Wait for user response *=
/
+#define FS_EVENT_ON_NS         BIT_ULL(34)     /* For namespace watchers *=
/

 #define FS_PERM_EVENT(mask)    (FS_EVENT_IS_PERM | (mask))
+#define FS_NS_EVENT(mask)      (FS_EVENT_ON_NS | (mask))

 /*
  * Directory entry modification events - reported only to directory
@@ -136,7 +138,7 @@
 #define ALL_FSNOTIFY_FLAGS  (FS_ISDIR | FS_EVENT_ON_CHILD | FS_DN_MULTISHO=
T)

 /* Kernel internal 64bit flags */
-#define ALL_FSNOTIFY_KERN_FLAGS  (FS_EVENT_IS_PERM)
+#define ALL_FSNOTIFY_KERN_FLAGS  (FS_EVENT_IS_PERM | FS_EVENT_ON_NS)

 #define ALL_FSNOTIFY_BITS   (ALL_FSNOTIFY_KERN_FLAGS | \
                             ALL_FSNOTIFY_EVENTS | \

---

TBH, I don't remember whether I was discouraged for some reason
or if I had started to question the value of this
or if I thought it was better to send the simpler version first.

Anyway, I am fond of this approach so I will give it a try.

I went back and forth about exporting this explicitly in uAPI and
require that all fanotify_mark() calls on namespace objects
(add,remove,flush) always carry the explicit FS_EVENT_ON_NS
flag and/or in the outgoing mask.

or that they are defined as:
#define FAN_NS_CREATE (__FAN_NS_CREATE | FS_EVENT_ON_NS)

Also if we do that, we need to think of the least ugly way to handle
FAN_MNT_ATTACH & FAN_MNT_DETACH.

Your thoughts on this?

Thanks,
Amir.
