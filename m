Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 949B5314D05
	for <linux-fsdevel@vger.kernel.org>; Fri, 24 Apr 2026 19:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777060790; cv=pass; b=SBL1DjtHsAd0VPkPKvXFGU/Oup7I7+thWggkDQ7br+z7AOtYzHQiaHBTUP/uR0iG43b6i/pIy8T9huL0kkrGh3drQoqOTSLcFj5ENIbAzOx3gDW/DFsJVXAtLlvoTbkQfHoROXoIF0/E5FgukClaYBUuUXeHjlkGQYv+cuYB8Eg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777060790; c=relaxed/simple;
	bh=jQL8GMB+bamazijKjBwPkWhITrkdXr4CHsyXyn7/HDQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JZXYOn+6lmI4NoqTMdu2VIpZtw3oC7U9rQBwKas91f7vB4UAp959u1M05ohEHWVcF39utKaXEEwJudcbSaMW9YZN88W/A0fnaAJTu8rXK8xGDdEV4CIo/444/kLmP9Kheo1SyE2VDfj+GTVw3t0q1TFXov9yjstpfIHHLBYMYZQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=b7oXi7LU; arc=pass smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b7oXi7LU"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-50d836552daso4694591cf.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Apr 2026 12:59:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777060787; cv=none;
        d=google.com; s=arc-20240605;
        b=Oa77oynMyZ8m4+fhFA818LJCtkzyXXaPk9LxNbryv3usYG73neLt2Z06hBqeZmPN0r
         Ka+0i2oQahiplv2EQ3gEYbxZyv6l/NpjvpgDkBgTqFBow8Iu1Ov0WfSpqI3N+UO/l1ej
         jvviLHR16fG8oZcu5v7Qno13Gkbl3fJDKaj0C+K8iRa9UNGxZLrGComkyVEFvvsCwq9Z
         zjFgGwuP6qAIdPaXXSThIuF1UczW9SO9Rj2BBJqjSuZEHtuLZTD/LxUw+rbbYKedV3tA
         yDSyb4NyCu45M0SAihRjfV73K6DobZP7J/NT0sATOLZ+aXAqgGDIF0JJkaCfeQvwxODb
         kQrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5f8KT4elycAtFJ0kXecV1QCZWUTmhOqicbo482jUwJc=;
        fh=FVSH1i/Tfwk5wpiI5nbKuhA4oP12+EC6S/YVTw+h+SY=;
        b=jAXZuEPSPk9yyqGYENOMj7oWexEkY1th6tzdMnCJHDY7TaTH0GtqZ/VWA2BDsmzfoS
         0uS7xhIX3XesVGLJg+Dzu6q9akOp7cOiQC95BI84/YaF1uaNge5Tx61AI4112Y+zJHYV
         Ttkqs+hYLd2hO12a+4/2wZyf5w3BKNVuGmaVrx7zPchB+CuuSD/QWXCmDsoGemrgE9pu
         +NFgrzSysMiToYDVKHRAYI1oGeOaE/6hpb1gELOtmDbgznBD8tdwnmy/TiTzOCD8r0Mw
         eZaodxbe8weZrvjDGT0W8A0FBY3behTXs5pf/imWM4WnvmkyRG6WAR6fqI1osrK+Sd/e
         lviA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777060787; x=1777665587; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5f8KT4elycAtFJ0kXecV1QCZWUTmhOqicbo482jUwJc=;
        b=b7oXi7LUnFZYllOlVy/LDM9NFU0ejfKiIrMq/Z0vAJV/ETSnPtz7sULuqWKRdUm4Q6
         omOxQj1lcofzc+gHrgPG/8UE+EqXM6aqnsFMfdgiLgx6zfHfExcotZo3NQFfmtDn0c60
         KKz5Pev5TwTLaz8/hTmUp5v3J4oIyfJza6S3bz8Gmnf//h+kQGGQpv4hyZbqtMATHBEa
         9VRJvC0EegZGJpfgLRfM2Kn/sieBWPMrPXc347vB3ys0Dr3ugtHphykCLhEt+CJ9H9DO
         FuAqZS8a+aNhvhieE8QxnNZ9jIM8Oy9QFSI1bPOTGu9EQEHvrprP2xMcpxuRZ1xS8+wa
         /mZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777060787; x=1777665587;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5f8KT4elycAtFJ0kXecV1QCZWUTmhOqicbo482jUwJc=;
        b=RNLTSBABDkQWKlQwuikX2Y2VfcISDZQQbvTQEG5KSLJbXZoZr6J3U87J2Oo3mSH/ZA
         mVysYx6uzoIoD5QHNUOGBEFRBbjiLtBHx6L4i4g6Grfil8MqDcsvp9hvK/08EJlfeNV4
         VaiCtpxE+DGv5IvLk4RaWWhOhdwNTtFF41DOO/jmf5rIS6VW0aSsp2azqtKV2TmK2SHI
         fKRJ+BUPGBF0VOzV955gCYW2TY2wjOkPbpMNy4+37ca3/z8cAtSz1rTfmcXtNt/z7kLG
         mOpFh9ulnn21BKv59UNzcqbFPLKwSE91Hub0P653GPhD0Be1o3ffRVerHLEjiY6zAl4q
         Yq/g==
X-Forwarded-Encrypted: i=1; AFNElJ8wYR0acszl6wG/kPEkLPdkcFuBLG3jga/Z7DhF/n8LSjC6jyA7jv8Por71njrhAKxEbJKzdUn83ZTd9gVU@vger.kernel.org
X-Gm-Message-State: AOJu0YyBVKa0mRVZhcISQ9IUdnrpAk/LKU8X0MILlPPfOLVy0eldIwia
	Yx+wLr3yxFE0ZJXsUJAYEVMgcNNrtVurSuJpIUwuav9lfYLHBh4IDhU9ulRTLHoN/1uMh6EAGCd
	jzRoS45NTD/gpTK7Zula6tS5kaOJqJJmEOKH/KDls
X-Gm-Gg: AeBDieuXnaFQJjoFkiXbvrWNeIxY/BUc0/k4+coNlTLrAPPaqrdnmuvA93HavX0aVBM
	jshm52ECvVp5CIvEpEzeHQffmcr6fw+0iNj5VHT+HLBzo5KWDEkVp1C+ndCmYfySPuuYQH1Irhh
	n5WFBfaHKNIkZxFVQPXBRvOnVJdi5i3DMfr9ljAepP9UdariWI5DfTdnDWJ4c9w4Hd9llMhKwMO
	YyuN11HSMBgVgZEv2JeU2ZoDitL5VmVJJjOyDnVxO7wWBqLMH47vDy7rzUyLYvm2k1CGIdNNelu
	Z/VFCi8TRLjR1obpFwbGIGFBQ+c=
X-Received: by 2002:a05:622a:8d0c:b0:50b:8d3c:5bd7 with SMTP id
 d75a77b69052e-50e441a9a18mr45045201cf.9.1777060787000; Fri, 24 Apr 2026
 12:59:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260424070234.190145-1-surenb@google.com> <20260424070234.190145-4-surenb@google.com>
 <qxxhshfoe5tph4z324fzl74r532bxdrdvll2xvhaeken6bsdwb@q2wk2nbvxr3p>
In-Reply-To: <qxxhshfoe5tph4z324fzl74r532bxdrdvll2xvhaeken6bsdwb@q2wk2nbvxr3p>
From: Suren Baghdasaryan <surenb@google.com>
Date: Fri, 24 Apr 2026 12:59:35 -0700
X-Gm-Features: AQROBzD5xA_3c0_hTUm6u9T-bbzWrkTL-rrbMD7rk0vNpvDqT-w5J6qxPpAkp5U
Message-ID: <CAJuCfpE5C9UpkrAEvm6amw7=JYRoXeiSJuPFJnb+LRrVwn4ntA@mail.gmail.com>
Subject: Re: [PATCH 3/3] selftests/proc: add /proc/pid/smaps tearing tests
To: "Liam R. Howlett" <liam@infradead.org>
Cc: akpm@linux-foundation.org, ljs@kernel.org, vbabka@kernel.org, 
	david@redhat.com, willy@infradead.org, jannh@google.com, paulmck@kernel.org, 
	pfalcato@suse.de, shuah@kernel.org, hsukrut3@gmail.com, 
	richard.weiyang@gmail.com, reddybalavignesh9979@gmail.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 24, 2026 at 11:23=E2=80=AFAM Liam R. Howlett <liam@infradead.or=
g> wrote:
>
> On 26/04/24 12:02AM, Suren Baghdasaryan wrote:
> > Add MAPS_FILE environment variable to select whether the tests to be ru=
n
> > for /proc/pid/maps or /proc/pid/smaps. Add support for testing smaps fi=
le
> > by reusing the same logic as with maps file but skipping all the data
> > except for the VMA addresses, which are the only part relevant for the
> > tearing tests. Skip PROCMAP_QUERY parts of the tests because smaps does
> > not implement that ioctl.
> >
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
>
> One comment question, otherwise..
>
> Reviewed-by: Liam R. Howlett <liam@infradead.org>
>
> > ---
> >  tools/testing/selftests/proc/proc-maps-race.c | 176 +++++++++++++-----
> >  1 file changed, 132 insertions(+), 44 deletions(-)
> >
> > diff --git a/tools/testing/selftests/proc/proc-maps-race.c b/tools/test=
ing/selftests/proc/proc-maps-race.c
> > index c5031b0593b7..b677bc23cab9 100644
> > --- a/tools/testing/selftests/proc/proc-maps-race.c
> > +++ b/tools/testing/selftests/proc/proc-maps-race.c
> > @@ -17,8 +17,8 @@
> >   */
> >  /*
> >   * Fork a child that concurrently modifies address space while the mai=
n
> > - * process is reading /proc/$PID/maps and verifying the results. Addre=
ss
> > - * space modifications include:
> > + * process is reading /proc/$PID/maps and /proc/$PID/smaps, verifying =
the
>                                          ^^^ and? Should this be or?  It
>                                          doesn't match your commit
>                                          message.

Quite right. I'll fix it. Need to post a new version anyway since
Sashiko found a couple of issues.

>
>
> > + * results. Address space modifications include:
> >   *     VMA splitting and merging
> >   *
> >   */
> > @@ -73,6 +73,11 @@ enum test_state {
> >       TEST_DONE,
> >  };
> >
> > +enum maps_file {
> > +     MAPS,
> > +     SMAPS,
> > +};
> > +
> >  struct vma_modifier_info;
> >
> >  FIXTURE(proc_maps_race)
> > @@ -83,6 +88,7 @@ FIXTURE(proc_maps_race)
> >       struct line_content last_line;
> >       struct line_content first_line;
> >       unsigned long duration_sec;
> > +     enum maps_file maps_file;
> >       int shared_mem_size;
> >       int skip_pages;
> >       int page_size;
> > @@ -199,6 +205,57 @@ static void copy_last_line(struct page_content *pa=
ge, char *last_line)
> >       last_line[end - pos] =3D '\0';
> >  }
> >
> > +static bool copy_first_entry(struct page_content *page, char *first_li=
ne)
> > +{
> > +     const char *start_pos =3D page->data;
> > +
> > +     while (start_pos < page->data + page->size) {
> > +             unsigned long start_addr;
> > +             unsigned long end_addr;
> > +             char *end_pos;
> > +
> > +             end_pos =3D strchr(start_pos, '\n');
> > +             if (!end_pos)
> > +                     break;
> > +
> > +             if (sscanf(start_pos, "%lx-%lx", &start_addr, &end_addr) =
=3D=3D 2) {
> > +                     strncpy(first_line, start_pos, end_pos - start_po=
s);
> > +                     first_line[end_pos - start_pos] =3D '\0';
> > +                     return true;
> > +             }
> > +
> > +             start_pos =3D end_pos + 1;
> > +     }
> > +
> > +     return false;
> > +}
> > +
> > +static bool copy_last_entry(struct page_content *page, char *last_line=
)
> > +{
> > +     const char *end_pos =3D page->data + page->size - 1;
> > +     const char *start_pos;
> > +
> > +     while (end_pos > page->data) {
> > +             unsigned long start_addr;
> > +             unsigned long end_addr;
> > +
> > +             /* skip last newline */
> > +             start_pos =3D end_pos - 1;
> > +             /* search previous newline */
> > +             while (start_pos > page->data && start_pos[-1] !=3D '\n')
> > +                     start_pos--;
> > +             if (sscanf(start_pos, "%lx-%lx", &start_addr, &end_addr) =
=3D=3D 2) {
> > +                     strncpy(last_line, start_pos, end_pos - start_pos=
);
> > +                     last_line[end_pos - start_pos] =3D '\0';
> > +                     return true;
> > +             }
> > +
> > +             end_pos =3D start_pos - 1;
> > +     }
> > +
> > +     return false;
> > +}
> > +
> >  /* Read the last line of the first page and the first line of the seco=
nd page */
> >  static bool read_boundary_lines(FIXTURE_DATA(proc_maps_race) *self,
> >                               struct line_content *last_line,
> > @@ -207,8 +264,16 @@ static bool read_boundary_lines(FIXTURE_DATA(proc_=
maps_race) *self,
> >       if (!read_two_pages(self))
> >               return false;
> >
> > -     copy_last_line(&self->page1, last_line->text);
> > -     copy_first_line(&self->page2, first_line->text);
> > +     if (self->maps_file =3D=3D MAPS) {
> > +             copy_last_line(&self->page1, last_line->text);
> > +             copy_first_line(&self->page2, first_line->text);
> > +     } else if (self->maps_file =3D=3D SMAPS) {
> > +             if (!copy_last_entry(&self->page1, last_line->text) ||
> > +                 !copy_first_entry(&self->page2, first_line->text))
> > +                     return false;
> > +     } else {
> > +             return false;
> > +     }
> >
> >       return sscanf(last_line->text, "%lx-%lx", &last_line->start_addr,
> >                     &last_line->end_addr) =3D=3D 2 &&
> > @@ -464,6 +529,7 @@ FIXTURE_SETUP(proc_maps_race)
> >  {
> >       const char *verbose =3D getenv("VERBOSE");
> >       const char *duration =3D getenv("DURATION");
> > +     const char *maps_file =3D getenv("MAPS_FILE");
> >       struct vma_modifier_info *mod_info;
> >       pthread_mutexattr_t mutex_attr;
> >       pthread_condattr_t cond_attr;
> > @@ -474,6 +540,18 @@ FIXTURE_SETUP(proc_maps_race)
> >
> >       self->page_size =3D (unsigned long)sysconf(_SC_PAGESIZE);
> >       self->verbose =3D verbose && !strncmp(verbose, "1", 1);
> > +     if (maps_file) {
> > +             if (!strcmp(maps_file, "maps")) {
> > +                     self->maps_file =3D MAPS;
> > +             } else if (!strcmp(maps_file, "smaps")) {
> > +                     self->maps_file =3D SMAPS;
> > +             } else {
> > +                     ksft_print_msg("Unknown maps file %s\n", maps_fil=
e);
> > +                     ksft_exit_fail();
> > +             }
> > +     } else {
> > +             self->maps_file =3D MAPS;
> > +     }
> >       duration_sec =3D duration ? atol(duration) : 0;
> >       self->duration_sec =3D duration_sec ? duration_sec : 5UL;
> >
> > @@ -540,7 +618,16 @@ FIXTURE_SETUP(proc_maps_race)
> >               exit(0);
> >       }
> >
> > -     sprintf(fname, "/proc/%d/maps", self->pid);
> > +     switch (self->maps_file) {
> > +     case MAPS:
> > +             sprintf(fname, "/proc/%d/maps", self->pid);
> > +             break;
> > +     case SMAPS:
> > +             sprintf(fname, "/proc/%d/smaps", self->pid);
> > +             break;
> > +     default:
> > +             ksft_exit_fail();
> > +     }
> >       self->maps_fd =3D open(fname, O_RDONLY);
> >       ASSERT_NE(self->maps_fd, -1);
> >
> > @@ -675,20 +762,20 @@ TEST_F(proc_maps_race, test_maps_tearing_from_spl=
it)
> >               last_line_changed =3D strcmp(new_last_line.text, self->la=
st_line.text) !=3D 0;
> >               first_line_changed =3D strcmp(new_first_line.text, self->=
first_line.text) !=3D 0;
> >               ASSERT_EQ(last_line_changed, first_line_changed);
> > -
> > -             /* Check if PROCMAP_QUERY ioclt() finds the right VMA */
> > -             ASSERT_TRUE(query_addr_at(self->maps_fd, mod_info->addr +=
 self->page_size,
> > -                                       &vma_start, &vma_end));
> > -             /*
> > -              * The vma at the split address can be either the same as
> > -              * original one (if read before the split) or the same as=
 the
> > -              * first line in the second page (if read after the split=
).
> > -              */
> > -             ASSERT_TRUE((vma_start =3D=3D self->last_line.start_addr =
&&
> > -                          vma_end =3D=3D self->last_line.end_addr) ||
> > -                         (vma_start =3D=3D split_first_line.start_addr=
 &&
> > -                          vma_end =3D=3D split_first_line.end_addr));
> > -
> > +             if (self->maps_file =3D=3D MAPS) {
> > +                     /* Check if PROCMAP_QUERY ioclt() finds the right=
 VMA */
> > +                     ASSERT_TRUE(query_addr_at(self->maps_fd, mod_info=
->addr + self->page_size,
> > +                                               &vma_start, &vma_end));
> > +                     /*
> > +                      * The vma at the split address can be either the=
 same as
> > +                      * original one (if read before the split) or the=
 same as the
> > +                      * first line in the second page (if read after t=
he split).
> > +                      */
> > +                     ASSERT_TRUE((vma_start =3D=3D self->last_line.sta=
rt_addr &&
> > +                                  vma_end =3D=3D self->last_line.end_a=
ddr) ||
> > +                                 (vma_start =3D=3D split_first_line.st=
art_addr &&
> > +                                  vma_end =3D=3D split_first_line.end_=
addr));
> > +             }
> >               clock_gettime(CLOCK_MONOTONIC_COARSE, &end_ts);
> >               end_test_iteration(&end_ts, self->verbose);
> >       } while (end_ts.tv_sec - start_ts.tv_sec < self->duration_sec);
> > @@ -758,17 +845,18 @@ TEST_F(proc_maps_race, test_maps_tearing_from_res=
ize)
> >                                       strcmp(new_first_line.text, resto=
red_first_line.text),
> >                                       "Expand result invalid", self));
> >               }
> > -
> > -             /* Check if PROCMAP_QUERY ioclt() finds the right VMA */
> > -             ASSERT_TRUE(query_addr_at(self->maps_fd, mod_info->addr, =
&vma_start, &vma_end));
> > -             /*
> > -              * The vma should stay at the same address and have eithe=
r the
> > -              * original size of 3 pages or 1 page if read after shrin=
king.
> > -              */
> > -             ASSERT_TRUE(vma_start =3D=3D self->last_line.start_addr &=
&
> > -                         (vma_end - vma_start =3D=3D self->page_size *=
 3 ||
> > -                          vma_end - vma_start =3D=3D self->page_size))=
;
> > -
> > +             if (self->maps_file =3D=3D MAPS) {
> > +                     /* Check if PROCMAP_QUERY ioclt() finds the right=
 VMA */
> > +                     ASSERT_TRUE(query_addr_at(self->maps_fd, mod_info=
->addr,
> > +                                               &vma_start, &vma_end));
> > +                     /*
> > +                      * The vma should stay at the same address and ha=
ve either the
> > +                      * original size of 3 pages or 1 page if read aft=
er shrinking.
> > +                      */
> > +                     ASSERT_TRUE(vma_start =3D=3D self->last_line.star=
t_addr &&
> > +                                 (vma_end - vma_start =3D=3D self->pag=
e_size * 3 ||
> > +                                  vma_end - vma_start =3D=3D self->pag=
e_size));
> > +             }
> >               clock_gettime(CLOCK_MONOTONIC_COARSE, &end_ts);
> >               end_test_iteration(&end_ts, self->verbose);
> >       } while (end_ts.tv_sec - start_ts.tv_sec < self->duration_sec);
> > @@ -838,20 +926,20 @@ TEST_F(proc_maps_race, test_maps_tearing_from_rem=
ap)
> >                                       strcmp(new_first_line.text, resto=
red_first_line.text),
> >                                       "Remap restore result invalid", s=
elf));
> >               }
> > -
> > -             /* Check if PROCMAP_QUERY ioclt() finds the right VMA */
> > -             ASSERT_TRUE(query_addr_at(self->maps_fd, mod_info->addr +=
 self->page_size,
> > -                                       &vma_start, &vma_end));
> > -             /*
> > -              * The vma should either stay at the same address and hav=
e the
> > -              * original size of 3 pages or we should find the remappe=
d vma
> > -              * at the remap destination address with size of 1 page.
> > -              */
> > -             ASSERT_TRUE((vma_start =3D=3D self->last_line.start_addr =
&&
> > -                          vma_end - vma_start =3D=3D self->page_size *=
 3) ||
> > -                         (vma_start =3D=3D self->last_line.start_addr =
+ self->page_size &&
> > -                          vma_end - vma_start =3D=3D self->page_size))=
;
> > -
> > +             if (self->maps_file =3D=3D MAPS) {
> > +                     /* Check if PROCMAP_QUERY ioclt() finds the right=
 VMA */
> > +                     ASSERT_TRUE(query_addr_at(self->maps_fd, mod_info=
->addr + self->page_size,
> > +                                               &vma_start, &vma_end));
> > +                     /*
> > +                      * The vma should either stay at the same address=
 and have the
> > +                      * original size of 3 pages or we should find the=
 remapped vma
> > +                      * at the remap destination address with size of =
1 page.
> > +                      */
> > +                     ASSERT_TRUE((vma_start =3D=3D self->last_line.sta=
rt_addr &&
> > +                                  vma_end - vma_start =3D=3D self->pag=
e_size * 3) ||
> > +                                 (vma_start =3D=3D self->last_line.sta=
rt_addr + self->page_size &&
> > +                                  vma_end - vma_start =3D=3D self->pag=
e_size));
> > +             }
> >               clock_gettime(CLOCK_MONOTONIC_COARSE, &end_ts);
> >               end_test_iteration(&end_ts, self->verbose);
> >       } while (end_ts.tv_sec - start_ts.tv_sec < self->duration_sec);
> > --
> > 2.54.0.545.g6539524ca2-goog
> >
