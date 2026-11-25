Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795592818;
	b=O/DFSQfgOjhIOa3q42mMztAmgwISasv5jX7vvmrt8AnUGhKv5x44fBjHUcCUypTEmtTq
	 QOBXGBRvpwv9JlDhpSplRLciktwiPCDVwY2KHb/Jw2PDUqRoUWsphNKv5gMKsAkGQ1CC9
	 RKXMbs+kSiJM9Z5gun17UoMjrh2+mjmyW6BA4RCitEtWvWob2N9Prv9ly2KJhQjQOPws1
	 2Wcidjjg9v7vX2UNwaRLtl8N6xGSy3ka3Dyw+6K9eDi5NKH8rDL7G74BTMLYXF3FEnD7j
	 /x0SGXeiKAZ7cz/sxnmYkKUj5xLTon4zaEZ1dQNJpqsTaX2V+OH8PqIpAzkSlTlHR+A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795592818;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=U/rJwxOFAuUYoG0w11daH5oi3dDRM84YiGwVnaiS5js=;
	b=FM0gjZ7KRmFNqcm9u6prug73xIQ6DfN65KJ8nnFqpRoJOUxGRsx3vBF3Yy/gCmOK3PvZ
	 EnUNXijw3WkDKTCFrWYGSuWCLdHdAKi7ul17Y5H9HDPn5gxoZaxgcvE4nmiJF4iCrTAx9
	 i3iq3hfYaSNJCeIKPE05nDPkp3dszoNWA55aUhpLRlmNyQLQRP2nE0oggLCCVfj9cbKZC
	 eLTSFkDKYnobfB1r839hPNdMKz2/z4EmWh52Zq9wwpA4LceFmXH7WKdlMc9HUhPbtvWdM
	 g6xZ44bpcg9K1C/OVhPBxy6OtY/BJZUZ5QLe4oKE/xDcclaYhlQDHeSN7MW0e9o3Qsw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VtPZoNHl;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.52
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B299606A680
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Nov 2026 07:46:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8B299606A680
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VtPZoNHl
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6ba1e22ff4dso6391570a12.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Nov 2026 23:46:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795592817; cv=none;
        d=google.com; s=arc-20260327;
        b=KInIKZxsCAzVlfFUet59zfZ2xGzChxwfkgvqrON0ihM1TBBaEzt/NSEGVuTWFdbqYL
         IutQsL4fdQ3KnaYwAat3Bl5KxO8+vnbeeFLruuVOMfCL+Rpd1DVmlTUasp3SOum8nLAT
         XaEYTP+fY1Wke/gu6IoY+TAEjFvHtBkLo0WwkX4RM3k64vjVDIf9+jDQHot1s/cAhZNq
         7Y0W/SDsqOfvrr2bShlVwLIPZD/hRrrPnem+3rLSfGkMB1vXpYGsRR2mAUErM2Bn0kuA
         0VkYm1TU9aekZrhDuHF7G0lR7tSgJrMx3vWQybNA1j3Geo8jJmrIdJ9j9cXwn/fuoa68
         lkkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=U/rJwxOFAuUYoG0w11daH5oi3dDRM84YiGwVnaiS5js=;
        fh=rGESJyGZ3aA92m2I39I2EMcSZUupSERNEU8PwiLH0Y8=;
        b=WKHp4eMkaW+oUbP2gwKsbWTrr7/CMaHlAEkCWQ6jwnyWc91mcMBF8Z41SqvwMcQBVm
         ZWwokdBtYez+HBmsA1OSWwpQsPEVbqIwwqNp7tUI50d5plUwMyKbWuuanPfbbgpIIb+M
         CEht3DAGv85sXlJw7IjPdQlSgeEbHi6P+xCmMky04f7SprjUlBS7ZDxNJtavpDRoJuRF
         g95hbH6GiYROjUJFvBHWXQ+32sb9jDbRHCFPV9qm3PSAMenN0uA3Ew7U8oQ9qoZ6wpKm
         Hbqawuz/5RYQA47K1WlSpuy5jFFqw/qwR6a33qQELdatW7an3KqV7u0qOVxSAefkoneP
         C/NA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795592817; x=1796197617; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=U/rJwxOFAuUYoG0w11daH5oi3dDRM84YiGwVnaiS5js=;
        b=VtPZoNHlAXAQsj5bEHPGJ0pH9PH+uAptAVb7ng3RQd4KiJ/yixf4gO3gkxsw3iaRZm
         TWYv9oLVeFRy/ZbQMvSebdbDh6oF3peMQb3sRpaZPL1x9gcKT+XIi0voQruLQB5u4p0e
         v25GZIT9BolYen7M3/HNj9XYRM+Q5VJKoqYNPrzQ3vsTJva0k7ksSmrLKDUYESt0apwP
         GYccdy2bcFoIocJnRk+sPfocFT/Y+ifzh1LGSuIBQJZbcbG22Cps1hM9Oa/4AuRiy7UR
         u+rmlD058+hFaFaOgT9Zjf/iqqOG6+Rhp4DwODMk8XJ0ka9oJKyo+mici67q2iA+cmiT
         f2HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795592817; x=1796197617;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=U/rJwxOFAuUYoG0w11daH5oi3dDRM84YiGwVnaiS5js=;
        b=mUbvnQbXfxrI5iv5ew6yfi944DWU/sXrNps2/ejMSLo7wEvv18JS8Y1Y7xrmeEMlU/
         qA9IzF/Kh8NnNWmY0O21d41ec/3C8KpEvuHYPZeFa0BurtmgOTJq4/bKnlp6EKLQhhtl
         +zjWiJ5L3YXZgm9e95eG+JD6WTtDgYhdQ5KDRVhI67NZCW57c3Oqnz2yl/CgX8XlQZ7k
         LefLQZeyRVAUlR/J6g5y1Ho6deqY5kV9+eza3bctz/wNkHd4z9587bvJa7bO4mUvoiWy
         1Lr+M7SM+TAweZMkM7XxG9oagLdyz6kCEr1pfmZ0Uxd5iE1Jx55RKeoG/+b43iKFRS3T
         XxYQ==
X-Forwarded-Encrypted: i=1; AL+hErFoYBXTEOXS7iScKD4VqX2ZGQ5fGe3yvRlj10cjePBWRP4N5lfjP+L8eUvGLsfWZ2z7lZq2boTAfVfWOKAN@vger.kernel.org
X-Gm-Message-State: APuU4Z+tKq32plNx1oA2ChcAwc2IvkefmCyKrK3KncPzqJeknKnkcIQa
	gov1vtRRKroXWeT1ajsA1VcXpiqdI+TCmQg2GWtsmOBTPfLkE61BuT0ge9sQkuynyqtLWJ02ut/
	y8/Pg/hn/2riwnoUmxIfQhdPmzgOTPf4=
X-Gm-Gg: AZFdTZd/PDaQ8W+p/tszfrfvT4hTkKdrI+FQGnaFtN3tnLV4Jz1UofU8W5LYV89Fma4
	qHDgu3age2cKqT/qWPB18UE73N81ycg/bAYc0quKRJgeFLdTXhs5QQ3PlgaAQVyBRdx5ip5ejtx
	KK0ClN92i1mMn2UPkp1bHjAmvIOSp5udQ/ZfVvRDZ34OMRSZVbJScQ/7pNc2woDtBKNiGczvpux
	8WQuQI8sQW5xEwgPKDYi9ftkWA8oDEFZt7zR9k1ucDhAXqu/JZsOq19zPQwu9hNm3hAv2WB5g5p
	1smDyhWwQzIyly+GX59akNGKW6JKCNoENZNl9rSOgWIyO88Y0UHN4vh2D9oci7BHkANsZh0rVjW
	qgcJjSFm329PJvtUD7OtuWOiCszA+6/yNXTv8FghbDyRnOxZP/53TVfHFkR+nx5aywilSiw==
X-Received: by 2002:aa7:d643:0:b0:6b8:8706:8e93 with SMTP id
 4fb4d7f45d1cf-6ba37e843d4mr8822550a12.20.1795592816544; Tue, 24 Nov 2026
 23:46:56 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261123221410.3328780-1-neilb@ownmail.net> <179550252639.1728055.4014817916838632741@noble.neil.brown.name>
 <CAOQ4uxgF6=QoD9RoAOPmxtvkq1jWf+gG1AsJzR=Kt3ROMA=X0g@mail.gmail.com> <aau5z6kck6a2efcjvzrt6gno6ljs4eioncgizeh7vfbc6ipkr3@hjxzdk5pvgmt>
In-Reply-To: <aau5z6kck6a2efcjvzrt6gno6ljs4eioncgizeh7vfbc6ipkr3@hjxzdk5pvgmt>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 25 Nov 2026 08:46:45 +0100
X-Gm-Features: Aa3M54o6U4varTbnF50WUavOdVKfl6Xl8YctE_By69EQZGlFRJs8IsX9InoQqak
Message-ID: <CAOQ4uxjXP4Zegb2Vgsv-yBeFmhvc8FT2bDKDcaM_t0=oJ5KpXQ@mail.gmail.com>
Subject: Re: [PATCH v6 0/5] Fix easy bits of the negative dentry problem
To: Jan Kara <jack@suse.cz>
Cc: NeilBrown <neil@brown.name>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Ian Kent <raven@themaw.net>, Jake Edge <jake@lwn.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 24, 2026 at 5:26=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
>
> On Tue 24-11-26 14:08:07, Amir Goldstein wrote:
> > On Tue, Nov 24, 2026 at 7:42=E2=80=AFAM NeilBrown <neilb@ownmail.net> w=
rote:
> > >
> > > On Tue, 24 Nov 2026, NeilBrown wrote:
> > > > This v6:
> > > >  - fixes the autofs changes in 1/5
> > >
> > > Sashiko says this is racy.  I think it is but the original code was j=
ust
> > > as racy.  Maybe the race isn't relevant.  I haven't properly understo=
od
> > > it yet.
> > >
> > > >  - updates d_duplicate() in 1/5
> > >
> > > The fix was seriously broken.  Sorry.
> > >
> > > >  - uses a new version of 2/5 from Amir
> > >
> > > Sashiko has something to say about this
> > >
> > >     Can clearing FSNOTIFY_CONN_FLAG_UPDATE_CHILDREN and dropping conn=
->lock
> > >     before fsnotify_set_children_dentry_flags() finishes allow a conc=
urrent
> > >     watch-adding syscall to return to userspace before the children's
> > >     DCACHE_FSNOTIFY_PARENT_WATCHED flags have been set?
> > >
> > > Thoughts?
> >
> > Sashiko is right, but this race is not new.
> > The same window exists upstream: if another thread's recalc observes
> > the 0->watching transition and does the walk, fanotify_mark() can retur=
n
> > to userspace before all children have DCACHE_FSNOTIFY_PARENT_WATCHED se=
t.
> >
> > What changes with this series is that the walk is sleepable, so the
> > window is longer, and in some workloads it could go from rare to
> > plausible. OTOH, skipping negative dentries may shorten the walk.
> >
> > The more important question is whether a child can be left without
> > PARENT_WATCHED permanently. Upstream it can: the transition can be
> > observed by a recalc from the mark destroy path, which never walks.
> > With FSNOTIFY_CONN_FLAG_UPDATE_CHILDREN that cannot happen.
> > Every transition sets the flag, and every caller that can add a watch
> > consumes it,
> > so a walk that started after the transition always runs and fixes the f=
lags.
> > What remains is the transient window above.
>
> I agree this is preexisting issue. Let's not block this series with it.

preexisting, but sleepable children walks could make an
improbable race actually observable, because the scans are not
serialized and could take longer (I don't know how the scheduler
treats a dying process which has its marks removed).
Just wanted to make sure that the point is clear.

>
> > I think a proper fix for the transient window needs a sequence counter
> > of scans in the connector. Each caller would wait until a scan that
> > started after its transition has completed, no matter which thread ran =
it.
> >
> > I think we can live with this v6 patch for your series and deal with
> > the remaining race later if we want to, but I am not sure and would
> > like to hear what Jan thinks.
> >
> > If you want, I can implement the sequence counter for v7.
>
> No sure what exactly you have in mind but a sequence counter per inode
> looks like an overkill for this. A global one can get contended and
> a bit hairy to manage but let's see...

I had a patch with another conn flag _CHILDREN_WATCHED
set at the end of the walk, which covers the Sashiko race, but
leaves some other corner cases (see below).

Are you concerned over the size of the mark connector?
I think that connectors should be rare and scarce.

With workloads that frequently add/remove watch,
Sleepable children walks could cause a situation where
scan that started a few add/remove cycles ago complete out
or order with the most recent walk.

Only the completion of the most recent walk can guarantee
that all the children dentries are watched.

This is a concept version of the generational walks.
The _UPDATE_CHILDREN flag is redundant here
I only left it so the concept patch does not need to change recalc_mask

Let me know if you want me to post a patch on top of Neil's patch set
or in place of the v6 patch, or nothing at all.

Thanks,
Amir.

void fsnotify_conn_set_children_dentry_flags(
                                        struct fsnotify_mark_connector *con=
n)
{
        unsigned int gen;
        bool update_children;

        if (!conn || conn->type !=3D FSNOTIFY_OBJ_TYPE_INODE)
                return;

        spin_lock(&conn->lock);
        if (conn->flags & FSNOTIFY_CONN_FLAG_UPDATE_CHILDREN) {
                conn->flags &=3D ~FSNOTIFY_CONN_FLAG_UPDATE_CHILDREN;
                conn->children_gen++;
                update_children =3D true;
        } else {
                /* Walk that consumed the update flag may still be in
progress */
                update_children =3D conn->children_done !=3D conn->children=
_gen &&
                                  fsnotify_conn_watches_children(conn);
        }
        gen =3D conn->children_gen;
        spin_unlock(&conn->lock);

        if (!update_children)
                return;

        fsnotify_set_children_dentry_flags(fsnotify_conn_inode(conn));

        spin_lock(&conn->lock);
        /* Concurrent walks may complete out of order */
        if ((int)(gen - conn->children_done) > 0)
                conn->children_done =3D gen;
        spin_unlock(&conn->lock);
}
