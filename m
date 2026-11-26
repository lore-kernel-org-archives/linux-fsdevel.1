Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.49
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795695897;
	b=MRKjaEpvv0M0vLYIIIyZHvPyCXCbphL2YKvjP2+Ey4TXWTjY8Tz+E6Tgu4PJsAcufRdZ
	 p1WL0nx3Z9h0gRlGGO8PH0CVhYBYSD1Bp6a5NuUxomybd+l0NvJx/ghZ+DUNOHNII7wlc
	 EMqverClVehznIGPb3Qp5/d4JpLpeWDbbyj9NzEbR2jezTlK1iVVaqhdF8EKgDLHTYZRq
	 Hi/B+Bt+D0gE/mYemtbOex+bSY8poOeAFM2SOHaqidnI0FnEyJQpr/+UeF6OrtNe5Xdtw
	 Q3zmnJ1zxuLOBxs6tGDFa102soppmY86xmjFJFtlxoRedkPsPYP4IDWu+sqoxSikYYQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795695897;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=XZDH8/OlegJAqtRzLs0OhPY77EyHVcKMopXFWjDtKVk=;
	b=kfZyNzI+tjBhmRHeup4O4CNzy0rDbDWR9jpjjJdUJxLCh2y9KLKv5xpVZWGRLn5vo6EO
	 jO+a+qjkW0HWBTB/q6xrX2+z4F0mMBKlH/a7SjUTZypTpdAmKsLqh/LuV+EgznxnPObpv
	 yf4Q7WSV2ynKxahbD3cz6MDTFK+A8CHswuT+yVFZt3PTDOAQ0scsogXewY8lP7BePKw9p
	 5tDaqgDb3dfwCgapvbnwoyGgr0BCxH4J7LoomIyCsFt1Pq1x0aNrZ+ii6GigzvdyRX7Jt
	 e/cazgqKScG8sytZ97tIGXI5A6Iip2G2RdzaQxbhwgqeAQXoAM5FYKtI8gzJT2RPB+Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wpl3gjDJ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.49
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64CC6606A31E
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Nov 2026 12:24:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 64CC6606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wpl3gjDJ
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6b167ffd132so10788375a12.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 Nov 2026 04:24:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795695896; cv=none;
        d=google.com; s=arc-20260327;
        b=R3q5BlaRMSGK6IZklL1/ZVd6eYSf29w8/iogQ/Ie98z+4HJg8qiyoxRd5ybvtvHUKs
         ktK0MnAKfhlER9I46RcqBXixDC/XN4TVN2Vo4YK/1NzvV++NH9qkTQ4AxstX5Zru7DKt
         9Y+mQvICYRfbI8cYcQaUFK1Rz7azzGi1i45tJTWlMflyNlY4RTJtxy+rQMnLfviAiXMJ
         96ivgMXOQIr7tIWToRi3ZW1VprhiDXhI+76gBTL5qKJvIil8242ZuJC4SnyQszer5mru
         SDo01cMHKm+UkONIapul1B4bZR7pjjw0Cgy7K3+7K8OPXmTR3ib2K4X4c5PgZeNCPF3d
         REPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XZDH8/OlegJAqtRzLs0OhPY77EyHVcKMopXFWjDtKVk=;
        fh=FolDjIUTimnbL1Hq0mze1gNj/ya/24Z75gH7um+tH2Y=;
        b=AbpfkrO+9Bt8hvk98oMFftNkzeuKS9HcNFYJhuCavq5i9TBLeQEpmgpXuU3xK87Z52
         EODOrJm+w2HCjIjH7m/Tqz+ktlYwlQZukUnOnqdlIOIHUWrO5N65+8M+7hSyDQUDGA0r
         +3UKgIX+w9oqCntnAH0WICK5tQnuPX/me+i6aRLrZDyhWIM/CkcxU443gHKL7P5+ULlv
         HWRZGl7bLzUHXHZcH8Hcr/80RB3zLTh/TeL633ESV1sTHlOvZiRWENWbDAybpPfYQZZY
         NPDxYWP0V+piP5vrSKOwXtD3jZTwVdIFOH86CzQuULZAzmWQDw+vS8PEkpEyi4/n8lfT
         Ex+A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795695896; x=1796300696; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XZDH8/OlegJAqtRzLs0OhPY77EyHVcKMopXFWjDtKVk=;
        b=wpl3gjDJfZU8pKQkUKCqhZXA3jfTYsxnLaC1vVhvk0sGuWyBPAirVTMYitrrnVT1eW
         ED71uiXeMe3JvDP/sCZ9At97Sc5QQ2AhE7zcGC3lQgNEGnDcuwiLW6/G22L1rO8pn22O
         CmmsEBKiS9J+UBLPgX/Ec+DNqUV+PaN6LJYTVUuQ4S3n9jiJsM+3vKpAGFwSOuJUV2pE
         X0fLxPdWMgd0rLoGz35zGaydFwsLmdlkkHrEGp91U5rYMMdYzOBvXs+1Qhi9Zv/JMoRi
         782319YDAAQMk1coTa2ALFViCg1XYsluiOftKA/vLc/wXWrlWG6rH/tqWUqc39NFnU3o
         mkXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795695896; x=1796300696;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XZDH8/OlegJAqtRzLs0OhPY77EyHVcKMopXFWjDtKVk=;
        b=mVB8BDykLLrw7OdFJa6ifgxfsQdm8fps/x5rcxTxl/AP8h/B3uyJkq8mF713UH48od
         q8XqykSSgotWr3mctn1GfsLVR2TTFnkLAMFXnsKTN68XO8QwsLC8qMFblzuwHKgQK8ZK
         CcuakNORasX3gSELDsWhDxnpLn05U62IuRnzuISOzqsIEpsN3yElixu7nd/jiNXlmfHM
         5+9TaOpQECr94RgitNEXw9pmskYFvexf+BAoudW+9wmhYz9bvJW6BTjLtd/8HRNFLA3s
         pcvNeNyCjiJ4dXyU/Lu1zvrqNsKihmSCbQgStrwPcONxwRMJFApwTjxuBIf1KTqBSaOq
         7naQ==
X-Forwarded-Encrypted: i=1; AL+hErHJ8XrN75Maz2uCL7flLPPSgevyShbWKhsswfsarr1YBdS2Mhkq1J0IfVLhk2LPpkBQykKTpzQlW+j+mCK/@vger.kernel.org
X-Gm-Message-State: APuU4Z+hYpC8AU+TezqoBtzFdGDH8A2rr0PqbJY2ePL8iVjz+25+IPbe
	ZFRcborCdLKveyQeTQ5YfPqLVYy6+nOTBIf9tQS/36cLBUIeC10PJ3t1zqAxPm3P3cDlgzPZHRp
	0NzHlVLOdY+U7fjtwthD6LTJmdSKXd+k=
X-Gm-Gg: AZFdTZfFMzTUNZfIlnz/oVitLEOwtLGNN+q82/ZzpxMo+VgTPO63bchrCXzr49r5Rne
	jO+b2AQqxR1aexW4SA4l2O3SgfXHeGoZkBpYmsQuBAR553H+NvJnnrMICdwzYd13AzHhiRSh7B7
	1YNylKPl5sifwNdq4EQMPLNLIJK55tTsqcNHCXjNE9hu9HnoauZVoKyVgZ3DEDCp4s+Dg3JYlbt
	Efv1Hr10ZwZENlM/RK78ws8xuDyvKqBH+ZHW7EjbQwOWUm6008lDm9QmLyLYCTGPSL7u1qBSJt4
	FRWOPGzt9UESMW9EUveQtxHvXT8IQyy91aBufNMCcJlO0SvAF70Z1b0PRy4LVu4Bf3UaVJPU73q
	j4Y7U01XmBMG1CCicjaKyfFhVfMQN4/kVrrzE13MaSr54d3f+JIpevaT0SvbaOSKj9KLkyQ==
X-Received: by 2002:a05:6402:4004:b0:6b5:8719:6d51 with SMTP id
 4fb4d7f45d1cf-6ba37e6f76amr16694535a12.32.1795695895250; Thu, 26 Nov 2026
 04:24:55 -0800 (PST)
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
 <CAOQ4uxgF6=QoD9RoAOPmxtvkq1jWf+gG1AsJzR=Kt3ROMA=X0g@mail.gmail.com>
 <aau5z6kck6a2efcjvzrt6gno6ljs4eioncgizeh7vfbc6ipkr3@hjxzdk5pvgmt>
 <CAOQ4uxjXP4Zegb2Vgsv-yBeFmhvc8FT2bDKDcaM_t0=oJ5KpXQ@mail.gmail.com>
 <sc6xnwguimy23dexr3eosbe64xmmewn5ml5gso4m5xozw6fqlt@2hji64vi7eaw>
 <CAOQ4uxisP8YTUaexsXw4-Fxg0vand236cg5eDKirLm=kuDwSQQ@mail.gmail.com> <dy726gpfomckyt3se66pkdfj7qlsvmu4ysr666h3w5hxkay3l3@ibdy5kcibpjn>
In-Reply-To: <dy726gpfomckyt3se66pkdfj7qlsvmu4ysr666h3w5hxkay3l3@ibdy5kcibpjn>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 26 Nov 2026 13:24:42 +0100
X-Gm-Features: Aa3M54rJNPNF5cBOaERtuGAfJFMzxrWdxCFdPfxK5cljHiAESEVQSi6Rq_C-PwY
Message-ID: <CAOQ4uxiZtxa75j8+wSSfYZFrAvwDuo8ZfYh5+07n+mZfSsa2mA@mail.gmail.com>
Subject: Re: [PATCH v6 0/5] Fix easy bits of the negative dentry problem
To: Jan Kara <jack@suse.cz>
Cc: NeilBrown <neil@brown.name>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Ian Kent <raven@themaw.net>, Jake Edge <jake@lwn.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 26, 2026 at 11:57=E2=80=AFAM Jan Kara <jack@suse.cz> wrote:
>
> On Wed 25-11-26 18:39:20, Amir Goldstein wrote:
> > On Wed, Nov 25, 2026 at 12:34=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
> > >
> > > On Wed 25-11-26 08:46:45, Amir Goldstein wrote:
> > > > On Tue, Nov 24, 2026 at 5:26=E2=80=AFPM Jan Kara <jack@suse.cz> wro=
te:
> > > > >
> > > > > On Tue 24-11-26 14:08:07, Amir Goldstein wrote:
> > > > > > On Tue, Nov 24, 2026 at 7:42=E2=80=AFAM NeilBrown <neilb@ownmai=
l.net> wrote:
> > > > > > >
> > > > > > > On Tue, 24 Nov 2026, NeilBrown wrote:
> > > > > > > > This v6:
> > > > > > > >  - fixes the autofs changes in 1/5
> > > > > > >
> > > > > > > Sashiko says this is racy.  I think it is but the original co=
de was just
> > > > > > > as racy.  Maybe the race isn't relevant.  I haven't properly =
understood
> > > > > > > it yet.
> > > > > > >
> > > > > > > >  - updates d_duplicate() in 1/5
> > > > > > >
> > > > > > > The fix was seriously broken.  Sorry.
> > > > > > >
> > > > > > > >  - uses a new version of 2/5 from Amir
> > > > > > >
> > > > > > > Sashiko has something to say about this
> > > > > > >
> > > > > > >     Can clearing FSNOTIFY_CONN_FLAG_UPDATE_CHILDREN and dropp=
ing conn->lock
> > > > > > >     before fsnotify_set_children_dentry_flags() finishes allo=
w a concurrent
> > > > > > >     watch-adding syscall to return to userspace before the ch=
ildren's
> > > > > > >     DCACHE_FSNOTIFY_PARENT_WATCHED flags have been set?
> > > > > > >
> > > > > > > Thoughts?
> > > > > >
> > > > > > Sashiko is right, but this race is not new.
> > > > > > The same window exists upstream: if another thread's recalc obs=
erves
> > > > > > the 0->watching transition and does the walk, fanotify_mark() c=
an return
> > > > > > to userspace before all children have DCACHE_FSNOTIFY_PARENT_WA=
TCHED set.
> > > > > >
> > > > > > What changes with this series is that the walk is sleepable, so=
 the
> > > > > > window is longer, and in some workloads it could go from rare t=
o
> > > > > > plausible. OTOH, skipping negative dentries may shorten the wal=
k.
> > > > > >
> > > > > > The more important question is whether a child can be left with=
out
> > > > > > PARENT_WATCHED permanently. Upstream it can: the transition can=
 be
> > > > > > observed by a recalc from the mark destroy path, which never wa=
lks.
> > > > > > With FSNOTIFY_CONN_FLAG_UPDATE_CHILDREN that cannot happen.
> > > > > > Every transition sets the flag, and every caller that can add a=
 watch
> > > > > > consumes it,
> > > > > > so a walk that started after the transition always runs and fix=
es the flags.
> > > > > > What remains is the transient window above.
> > > > >
> > > > > I agree this is preexisting issue. Let's not block this series wi=
th it.
> > > >
> > > > preexisting, but sleepable children walks could make an
> > > > improbable race actually observable, because the scans are not
> > > > serialized and could take longer (I don't know how the scheduler
> > > > treats a dying process which has its marks removed).
> > > > Just wanted to make sure that the point is clear.
> > >
> > > Yes, the window can be larger now but it still shouldn't be a practic=
al
> > > problem unless there are several watchers placing marks on insanely l=
arge
> > > dir in parallel. So I think we can live with the race for a while lon=
ger :)
> > >
> > > > > > I think a proper fix for the transient window needs a sequence =
counter
> > > > > > of scans in the connector. Each caller would wait until a scan =
that
> > > > > > started after its transition has completed, no matter which thr=
ead ran it.
> > > > > >
> > > > > > I think we can live with this v6 patch for your series and deal=
 with
> > > > > > the remaining race later if we want to, but I am not sure and w=
ould
> > > > > > like to hear what Jan thinks.
> > > > > >
> > > > > > If you want, I can implement the sequence counter for v7.
> > > > >
> > > > > No sure what exactly you have in mind but a sequence counter per =
inode
> > > > > looks like an overkill for this. A global one can get contended a=
nd
> > > > > a bit hairy to manage but let's see...
> > > >
> > > > I had a patch with another conn flag _CHILDREN_WATCHED
> > > > set at the end of the walk, which covers the Sashiko race, but
> > > > leaves some other corner cases (see below).
> > >
> > > Yes, I was also concerned about those races when thinking about that
> > > yesterday. Let's discuss below.
> > >
> > > > Are you concerned over the size of the mark connector?
> > > > I think that connectors should be rare and scarce.
> > >
> > > Yes, I was concerned about the size of the connector. On a second tho=
ught
> > > I tend to agree it wouldn't be a huge deal if we need it.
> > >
> > > > With workloads that frequently add/remove watch,
> > > > Sleepable children walks could cause a situation where
> > > > scan that started a few add/remove cycles ago complete out
> > > > or order with the most recent walk.
> > >
> > > Well, let's discuss the behavior of the walks and the flags. I imagin=
e we
> > > could have two bits like _UPDATE_CHILDREN and _UPDATE_CHIDREN_RUNNING=
.
> > > When children flags need update we set _UPDATE_CHILDREN. When we see
> > > _UPDATE_CHILDREN set, we call fsnotify_conn_set_children_dentry_flags=
().
> > > That function checks _UPDATE_CHIDREN_RUNNING. If already set, it wait=
s for
> > > it to get cleared and returns. If not set, it sets _UPDATE_CHIDREN_RU=
NNING,
> > > does the walk and clears both _UPDATE_CHILDREN and _UPDATE_CHIDREN_RU=
NNING.
> > >
> >
> > Yeh, I think that mostly works, with a minor variation.
> >
> > If the RUNNING flag is already set, the function waits for it to get
> > cleared and then checks the UPDATE flag again.
> > If the UPDATE flag is set, it clears the UPDATE flag, sets RUNNING
> > and starts the walk. At the end of the walk it clears only RUNNING,
> > so every time UPDATE is set, a walk starts after it.
> >
> > Anyway, serializing the walks per inode is a positive outcome
> > and better for our mental model.
>
> I agree. The only thing to watch out is that if the user could fast enoug=
h
> switch the inode between "children watched" and "no children watched" dur=
ing
> the walk, he could hold people waiting on RUNNING practically indefinitel=
y.
> And indeed with the example you mentioned below - one group with mark wit=
h
> FS_EVENT_ON_CHILD | FS_CREATE, another group with mark with FS_OPEN - wou=
ld
> create a situation where no single mark is watching children but together
> they create a mask which results in watching children. And by constantly
> adding and removing these marks userspace can stall other waiters on
> RUNNING flag without any bound (it depends only whether the victim task g=
ets
> scheduled and rechecks RUNNING flag before malicious task wakes up, clear=
s
> UPDATE, and sets RUNNING again).
>
> So I guess we'll have to use the sequence counter in the end and we'll ne=
ed
> to be careful. Something like:
>
>         spin_lock(&conn->lock);
>         gen =3D conn->scan_seqcount;
>         update_children =3D conn->flags & FSNOTIFY_CONN_FLAG_UPDATE_CHILD=
REN;
>         /* Scan in progress? */
>         if (gen & 1) {
>                 /*
>                  * We need to wait for scan to complete even if
>                  * UPDATE_CHILDREN is not set as somebody might have
>                  * started a scan for us.
>                  */
>                 gen++;
>                 wait_var_event_spinlock(&conn->scan_seqcount,
>                                         conn->scan_seqcount >=3D gen,
>                                         &conn->lock);
>                 /*
>                  * Somebody started the scan we need while we waited? Jus=
t
>                  * wait for it to complete.
>                  */
>                 if (conn->scan_seqcount =3D=3D gen + 1) {
>                         update_children =3D false;
>                         wait_var_event_spinlock(&conn->scan_seqcount,
>                                                 conn->scan_seqcount >=3D =
gen + 2,
>                                                 &conn->lock);
>                 }
>         }
>         /* Scan we needed is guaranteed to be complete */
>         if (!update_children || conn->scan_seqcount >=3D gen + 2) {
>                 spin_unlock(&conn->lock);
>                 return;
>         }
>         /* We will do the scan */
>         conn->scan_seqcount++;
>         conn->flags &=3D ~FSNOTIFY_CONN_FLAG_UPDATE_CHILDREN;
>         spin_unlock(&conn->lock);
>
>         fsnotify_set_children_dentry_flags(fsnotify_conn_inode(conn));
>
>         spin_lock(&conn->lock);
>         conn->scan_seqcount++;
>         wake_up_var_locked(&conn->scan_seqcount, &conn->lock);
>         spin_unlock(&conn->lock);
>
> > > > Only the completion of the most recent walk can guarantee
> > > > that all the children dentries are watched.
> > >
> > > So I don't think that's an issue. Look, if someone places a mark whic=
h
> > > watches children of an inode, we either end up updating the children =
flags
> > > or we wait for _UPDATE_CHIDREN_RUNNING to clear. So any mark update f=
rom
> > > userspace blocks, until the children walk is done and then they all r=
eturn.
> > > We hold the group lock during the wait so the mark that makes the par=
ent
> > > watch children is guaranteed to stay attached to the inode and subseq=
uent
> > > mask updates on the inode all result in the conclusion that children =
are
> > > watched (so fsnotify_parent() doesn't clear the children flags while =
we are
> > > still walking).
> > >
> > > One catch in the above argument are oneshot marks for inotify & dnoti=
fy.
> > > Inotify is actually fine since it grabs group lock when removing mark=
 after
> > > the event was sent (so the above argument holds). Dnotify doesn't gra=
b group
> > > lock when removing oneshot mark and so breaks the argument. I think w=
e
> > > should just make dnotify grab that lock to make our life simpler.
> > >
> > > Thoughts? Counter examples?
> > >
> >
> > My thought is that this makes my head explode..
> > I rather have a simpler mental model if possible, which is less
> > dependent on all the callers and other locks.
>
> I understand. Not sure if the above satisfies your wishes but I couldn't
> make it simpler...

It satisfies my concerns in that the logic is local and easy to follow.

Maybe it will be easier to read with a helper target variable and aim for
conn->scan_seqcount >=3D target, because the gen+2 arithmetics is a bit har=
d
to follow for all the cases, but not sure if the end result will be better.

Anyway, this is fine as far as I am concerned.
I assume that you will send a patch following Neil's patches.

Thanks,
Amir.
