Received: from mail-pz2-f42.google.com (mail-pz2-f42.google.com [74.125.228.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11CFD31195B
	for <linux-fsdevel@vger.kernel.org>; Mon, 21 Sep 2026 02:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789958010; cv=pass; b=KZbbLefv+P4Vl4olgTuTIg/n1x8yD/qSS7nFBAbI2Db3aH9iB+wcWmlwAUPyWFrdxS0Xy9ailhrmvkHYkzoLOLtwyHEktF8aUn6ctBr0079dX4zR1167jATaAGOtmBTvfZoRXsneEIoVlPyZ8NwWlq3U2bzqk9uUYQ1TEnslW7s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789958010; c=relaxed/simple;
	bh=J3vCu+pHHGK9T6Xt/sz+9R2/9vPugUzaNwdrlkLd5oA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tJpFhuH14LHNntnx0lY0Ci+OBoomafEfb8HPyzTc5ICL25phYaB5qt0azyRMWOJqRJSk6IgiTS9JQ5By/ocF4fMCx3KK7bJFcxSTUM8n2/7r+s2jK95HDMcwl01uUWGUCwAv3Uj84ywitrSauEOWXHOF8vzKfjE+/7RdLx+87uA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=MvLA8liI; arc=pass smtp.client-ip=74.125.228.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="MvLA8liI"
Received: by mail-pz2-f42.google.com with SMTP id 41be03b00d2f7-cc1cea4ae2cso2050825a12.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 20 Sep 2026 19:33:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789958008; cv=none;
        d=google.com; s=arc-20260327;
        b=qTUqYkdam907P6z2kd94fcVgtdd7X0HMI7SOaSUsIZA7Z9ejiYStpWGZmUQGIXiPJm
         RIk3DSd9mYTtE4pKIoZA4g7FFoRB5z2kGSn7YRqmtwl0uc8bqPXW4PIoIrlJv6bkLoVB
         d4xCbsepGmorD8M62rMC3LBFmlj9WVkwuw3jYlLTr81h2TRYzbeJZF0+fGxFsgOlwtCM
         oKO93V2XylhmJk34qcs2qtavRqHXfiaRBlIGk5tnp4qxGhji1dtTTe50nCO4pvL+5xzD
         H0yLb9FiheH1MemBvuDE2IHkaYlTGOciT4nHbIXzgZkotooBbzbitfrQ/nqVc8y3cnhT
         Ch0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Y0CX9NjM39oZwYo/+39OeXBXc2j3TkyIq6Vet5QN2Aw=;
        fh=zxdEHQRwKW2PFJo6KQz9oRkamffCxJo0W2vDk9kR+7Y=;
        b=C2bYxA5Gk8cGBg9oJ3n5qEgg8vYc+xaVHTy5ZzDsYVqm+FLHrfZ+Lbs9IvkOha293D
         mFX/WvynRizt6e9rmn3GASas1ccc/OzlQYdGYxqm9PIw0p7CVUiL9jBnnPyCZB5mmC5k
         Qit0a2+58aFfd1RPvcglU56LktKkq9u0f925VpcJ2wGVSAuDIfwmUWSE5k4GhYsJjjA7
         JydOvcmaNPxyasjJgrGL5P05dEJRyhYxrKqw3n4RGUpquI+ankrUOZYZUSALQwE2M36r
         IyxmFEvueMFt6FqcxSV1sLT9fQ7NjHKrbIWscu9x2SNctGMIFm/ZOe7fqTUhMqWLXUmR
         SlPg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1789958008; x=1790562808; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Y0CX9NjM39oZwYo/+39OeXBXc2j3TkyIq6Vet5QN2Aw=;
        b=MvLA8liIOnCDsY9Xgef7LSuV1d83UKiqFKIyA4l9PoHjlXoL8slmr9X0xPA2AsbiIg
         FdUrbPWbSBKM0Vtfxhe50Xz7TSLrPY7Y1z6u6qWuqk87gjTAGpX0mDiAZlq5NVyU4Gj4
         SaEjHBukdPbBkYqXeN2omfZjk4lUiutogvXMwukW09N0y5r8C4T8wDCbI8ClAopxmKKS
         Gz5B8G9ohVad0DF9X83p0oCcad0zErKxtgG5OlbPYVXELHSrGwOkYdSylXTTec2ucdqZ
         NLrcqUGJLpRSKQkg4hpB1uSef69+geJVbI1E7yQpbSEWwGaPWEe8rF27QkkZfz+VtBJl
         yAzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789958008; x=1790562808;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Y0CX9NjM39oZwYo/+39OeXBXc2j3TkyIq6Vet5QN2Aw=;
        b=kVBplMuHz5g5gpLP1cSsIvt0uo+cIf1fjoEpw0zTHslufkR9R6RcI8mL/qB4uVWf27
         amrngeY/vozaeNB6+raKIB5hEa4Eu7gjiBmddVBDi+VnTTHl66SM55oUQk0WV3iRvHlo
         UtdBO+mokRYC8pw/RcMUMUiPc3gZg4dvkL4ciULzJ/HXsLG+Y8MkC5BZ1zbX1+l5IR4Z
         0eLqrY1gIwvj9cpNk/pdJqXYvAsCUV+h9+SLYvhUUHmP6aq39gD3Q8s80gDss8bkI+oR
         Fw0UpIizrcfE/pTCWdbkvxn0sKqRTC57LGz1XDqf+4XjpIAS9AD5cjnZZ+BKsiO3XHJA
         RU4g==
X-Forwarded-Encrypted: i=1; AKwUvBy7ClpmoyfX6q5mRDlPzznoh8Pv0/ICQVaYae+DrwksTcIhfTDuif317PQw5MAsbPPEnegsE3iGq1uCjwxl@vger.kernel.org
X-Gm-Message-State: AFuF++mXk/OzQJstFdqujyDBScLHkoxilUM3fWdUZJzOKJEUMhnhsviC
	j1CSTfcu/x9aEfTDKxwLKNPnJCxRvbJSiX6AUCO3oz/XLNIJMupR39sCgO9XGKyUWi15zIffHE/
	Ag6reURmV5yKixZVn6ziT54u2ZNPGbpwFAbj0/Pfz
X-Gm-Gg: AYBFou1diU+T0EWVUB+Wk04t36Q758tXhbllnDf5hUKZteZNWfBALg1GPs/Bvr5+NQ+
	Rs1Q3VIEyyK4HQOfStDLLniUecO8J18eVhbuC3QCif6aoCKcELB/hiVlKTKqxIRqFSeSu4X8CvX
	NcEI/++qPQdJJrjW8xdzGmQISxQcOLxxs6cJZLUdria3SwY1T8xWLZmKmF8DHjhzgygQ6rRJgRd
	xT+7rCtwfJVFFTKRDvngCIMolb6x+mTZZcrH1o45iYEV1clc5HMGCfDId7OZwLSw36OVSJEeesx
	4pD8I+asuIS1ANupl5GTTgATsNQxLJ/JF4vE4MS6pjlKRB8u/Qn313UzQvOIq8bqEQgrD43DIvN
	3eLYxV97V
X-Received: by 2002:a05:6a20:394a:b0:3dd:a196:53a5 with SMTP id
 adf61e73a8af0-3dda19654e2mr9716786637.71.1789958008327; Sun, 20 Sep 2026
 19:33:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260907-selinux-pokemem-v3-0-0bafbaeafe50@google.com>
 <20260910-wohnbau-bezwangen-wegziehen-7a32dcf237b1@brauner>
 <CAHC9VhTE82bRRSXSUuMOdrfoMh=xOb5hDvqiKWzBKD1urab3hA@mail.gmail.com> <20260916-begossen-tischbein-abgemacht-e7dada3d1e56@brauner>
In-Reply-To: <20260916-begossen-tischbein-abgemacht-e7dada3d1e56@brauner>
From: Paul Moore <paul@paul-moore.com>
Date: Sun, 20 Sep 2026 22:33:15 -0400
X-Gm-Features: AcwNN1XJfic_AjA2ynJbPwX0hNkODxVU2hbKAKXrt_cjhAGvAIE6GT_12dvWT8I
Message-ID: <CAHC9VhRDpR+o9ThzajboAW4mpQWG7Yy0FemuowviyQXYvji7Qw@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] proc,security,selinux: let SELinux block
 FOLL_FORCE for /proc/self/mem
To: Christian Brauner <brauner@kernel.org>
Cc: Jann Horn <jannh@google.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	Jeff Xu <jeffxu@google.com>, =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, Ondrej Mosnacek <omosnace@redhat.com>, 
	selinux@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Lorenzo Stoakes <ljs@kernel.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Pedro Falcato <pfalcato@suse.de>, David Hildenbrand <david@kernel.org>, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 16, 2026 at 5:01=E2=80=AFAM Christian Brauner <brauner@kernel.o=
rg> wrote:
> On Mon, Sep 14, 2026 at 01:05:39PM -0400, Paul Moore wrote:
> > On Thu, Sep 10, 2026 at 3:48=E2=80=AFAM Christian Brauner <brauner@kern=
el.org> wrote:
> > > On Mon, 07 Sep 2026 23:00:15 +0200, Jann Horn wrote:
> > > > proc,security,selinux: let SELinux block FOLL_FORCE for /proc/self/=
mem
> > > >
> > > > The goal of this series is to let SELinux prevent the use of FOLL_F=
ORCE
> > > > when a process writes into /proc/self/mem and the system is configu=
red
> > > > with PROC_MEM_FORCE_ALWAYS (which used to be the default behavior, =
and
> > > > is still used by current Android devices).
> > > >
> > > > [...]
> > >
> > > Let's move this on a shared branch that both the vfs tree and the lsm
> > > tree pull. That's the standard way of handling dependencies between t=
wo
> > > subsystems that want to route code that touches both of them. Branch =
is
> > > stable.
> >
> > For some reason (/me looks at gmail) your email never hit my inbox, I
> > only noticed it now while reviewing Jann's patchset.
>
> Oh weird?
>
> > Christian, can you explain why you merged LSM code that I haven't
> > ACK'd?  We've talked about this in the past and I think I've been
> > fairly clear about it; I wouldn't merge VFS code without an
> > ACK/Reviewed-by/etc. from you or Al, I've been expecting the same
> > consideration from you.
> >
> > While I don't have a problem with a topic branch for this, can you
> > also explain why this topic branch should live in the VFS tree?  There
> > are more changes under security/ than fs/, and unless I've misread
> > Jann's cover letter, this entire patchset is focused around enabling
> > LSM/SELinux controls and not necessarily anything really new from a
> > VFS perspective.
>
> See the reply on the bpf thread. I think this just a misunderstanding. I
> was under the impression that with minor tweaks v2 was already acked by
> lsm people.
>
> In general, if a subsystems hooks into the vfs layer and filesystems
> that are directly maintained by the vfs layer then the vfs tree provides
> the shared branch. This is not at all specific to security. It's just
> more pronounced for notify or security because hooks are accepted
> layering violations that place constraints on how vfs code itself is
> organized.
>
> I think this is just a misunderstanding that would've been easy to
> clarify without the kerfuffle.

I'll follow up in the other thread, but I will just say here that had
this been the first time there had been an issue like this, it would
have likely been different.  However, from my perspective this was
continuing a pattern of behavior I had previously talked with you
about changing, and as a result I was much more annoyed having to
revisit the same process issues.

--=20
paul-moore.com
