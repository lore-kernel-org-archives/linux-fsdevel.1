Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 889C13988F1
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Mar 2026 19:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774898975; cv=none; b=mYbE3/hMQ8FO5xvJ32mT8S0ig5bgjhObiWbz9lqj9oVEPhWUiBJCi/7PWdwXkpY1c0kKAF+V8vHtO3e/7pXfrdQLy/5eqh4J2ooBoPbwNhZZHlhryTaIGcogPNEgZ+02LyIPvW1dY9Fvs3Sli4aHr/rqhq3lgV/MBfj+J3Fq8EA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774898975; c=relaxed/simple;
	bh=X86a7N9ZpC9u6NXVCkcFZwesqPOJzoytuyIsGiuOQ+Q=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IHpvKKpULRhd0hhwHatXkVPxnXSD7mpsp0UYPWBXh3SoF6yvpBwQxh+SVaGM1a2o4kgqOZLXK4irx0byWx+TbbHxuEUno65gnEFwXIhlORit/VtdfVVWjDQZJEmo4RMeCD197Gd8o0kBG7UR7GhANxIcZLe7wytdKFzMsU8cykM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Qy0239SI; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=mtXsh0sh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qy0239SI";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="mtXsh0sh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774898972;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LSbjPk4tV6YwISVAiI3NPdQ7cwRG2Qk80T6WiBS4eIs=;
	b=Qy0239SIpwryQMT2SyLbwm5G2kGgxWK+t37pK+EDJLgND02slQ+oGIH20F870QCZkq4To+
	C7y01DfIepLGaes3ZjjrdoAkPABksVdzsjlbShuPuynIRArvppCQkJFGJcP7lAQXsV8+3O
	L1XmbvwoQ8wkCaSkUBNRzvwU2mcjjDo=
Received: from mail-yx1-f70.google.com (mail-yx1-f70.google.com
 [74.125.224.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-327-vo2iyt6NN7ms4aXiRNbgPw-1; Mon, 30 Mar 2026 15:29:31 -0400
X-MC-Unique: vo2iyt6NN7ms4aXiRNbgPw-1
X-Mimecast-MFC-AGG-ID: vo2iyt6NN7ms4aXiRNbgPw_1774898970
Received: by mail-yx1-f70.google.com with SMTP id 956f58d0204a3-6501c35bb62so2313843d50.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 30 Mar 2026 12:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774898970; x=1775503770; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LSbjPk4tV6YwISVAiI3NPdQ7cwRG2Qk80T6WiBS4eIs=;
        b=mtXsh0shl13PAy35kofjk/j3O0AtEN6wdUiojT4ZlBPSoBEfpzCKwR0pxvikNDNlaR
         IANsSb6tpv9bQj4c4jtY6A7fwmDyXiCsm9XLrbHX+kUUYA6iFtVkAOaLPCUrjXAQmwOE
         WohFOQam5kDzLDwmPtUESxj2i7TLjJLQ6T2VKA/lj5Gx8HZ9y+Zu1NwNlqSAgU7ypaKn
         RJWk+8r0wPiwCZEGwFUIRdyPmcs3uuSgfpED1+3unRzf/Iqe0zrP7uraHR030CsGKSHM
         G2fXmNSYavroEEwe2O7K1+HE5nROVIAmXSvMYDYxHHLPLyQYN4zzUKFfmJbDrOzNcJsy
         SXYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774898970; x=1775503770;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LSbjPk4tV6YwISVAiI3NPdQ7cwRG2Qk80T6WiBS4eIs=;
        b=gBhMBr6H7bt9T3fXAOUmP+bG5R/bnCZyUMly6URrrKW8vdUkNj+YZr56Ma/Mop6tYX
         c+4N4qw3JEemoaVkdnufvycwexngqMz0q1Zh+31abLx4QVTkju81WUi2XUeroZz1G8te
         SQWGxOuW++efHlaL3u5uicZyIKEWj016EHd/fi2G3XlNjdkV5mwzB49ckFb+oWHTqr28
         YkrvZAArUz3GQBQbUKUA6P2IBzdDBfZDRShIAvQcXeixsD3uYrPQ6llBpEjUTVU+qJLt
         avCVfc+GcbcrSuim3tiKXjHbbaqfZTQDwnG8NQ+2ZLqBj4wk1cp0cF5s8D0qOWvJgYNM
         NwCw==
X-Forwarded-Encrypted: i=1; AJvYcCWPsukSZHEz5YxARMntOQrr5rDEUKTSwEVC+W8Hh+Nhze+Abgq24QUDvglwimAOgzxF75rdnDHgVyKTTu2A@vger.kernel.org
X-Gm-Message-State: AOJu0YxusgNBYFNa5rdXIYWjNWBXZL3Yy4InO28QGkFHQIygnwQmwWXv
	G1HDXsmfNqaddj2j9HBKvu7ROMu5gRc8UR2fy77BYKh42tMgFIwT2e9QZI6GAjd3pV+lfRJH0y8
	IZ4rVO1XGrcHd1oGP6MT6bMImpTQI4wFGOmROHatZDxGr3YfJ222fB5ber8qApwaHT0Q=
X-Gm-Gg: ATEYQzyvuVSEjxZ4HWpGZPwVjmW1ZUa8322qKHuvHDwKxJZq+FaVEblg3kHxLIGJMPJ
	xL+/jfXRtSfRVstIBS/FrTH5OmIwW+MNjn3ulboO+mXFPaeWRJ5X4Utg84YAHxY9xF6puAxmNx1
	ohJeFIbPt7pwwe3nInjQkpBUO0c8lTPhLsN5dSCv6zFkfZgd0BYaURSvmZ9pd5BVcVbWZEqPAGc
	I1jvUvJXJRBVcocK4rE0zZA1CTdyNC9Y3JeO8E5lCIFry3fe/FhafNHBeoSPMyz2OKBfPULteL+
	Or+9mLWRKUYUI6/YFdePzpAjWl6y02k6NELmXMSF/tSRclSrUCkzYSv+dtIHsBIzYOJCPFB2KOr
	hi0gHeBDa0DvViamwLxRVPz7NgOBEexYHD/JN+flC/OQc2TYwfFta
X-Received: by 2002:a05:690e:13cd:b0:650:1a14:b2e5 with SMTP id 956f58d0204a3-6501a14b8e8mr5673950d50.6.1774898970471;
        Mon, 30 Mar 2026 12:29:30 -0700 (PDT)
X-Received: by 2002:a05:690e:13cd:b0:650:1a14:b2e5 with SMTP id 956f58d0204a3-6501a14b8e8mr5673925d50.6.1774898969994;
        Mon, 30 Mar 2026 12:29:29 -0700 (PDT)
Received: from li-4c4c4544-0032-4210-804c-c3c04f423534.ibm.com ([2600:1700:6476:1430::29])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6500934ce74sm4441184d50.16.2026.03.30.12.29.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 12:29:29 -0700 (PDT)
Message-ID: <80ced2fd4d2dbaeaf2142875cd9b61557bb45d8e.camel@redhat.com>
Subject: Re: [PATCH v1 0/10] ceph: add manual client reset and selftests
From: Viacheslav Dubeyko <vdubeyko@redhat.com>
To: Alex Markuze <amarkuze@redhat.com>, ceph-devel@vger.kernel.org
Cc: idryomov@gmail.com, linux-fsdevel@vger.kernel.org
Date: Mon, 30 Mar 2026 12:29:28 -0700
In-Reply-To: <20260327143045.1393612-1-amarkuze@redhat.com>
References: <20260327143045.1393612-1-amarkuze@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43app2) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-03-27 at 14:30 +0000, Alex Markuze wrote:
> Manual client reset gives operators a way to break client/MDS capability
> ownership stalemates without unmounting the client. The reset blocks new
> metadata work, gives dirty state a bounded chance to drain, asks each MDS
> to close the session, and then tears the local sessions down so the clien=
t
> can rebuild clean state.
>=20
> The debugfs interface in this series is only the control surface used to
> develop and validate the reset flow. It is not the core feature, and the
> long-term intent is to have the client trigger the reset automatically
> when it detects the stuck condition.
>=20
> A reconnect-only reset would require MDS support for accepting reconnects
> outside the normal MDS RECONNECT phase. Because that support does not
> exist today, the series first wires up the reconnect-based worker for
> validation and then switches the recovery path over to direct session
> teardown.
>=20
> I split the work into smaller reviewable steps so the preparatory cleanup
> lands first, then the reset framework and control path, then the initial
> worker, then the direct-teardown refinements, and finally the single-clie=
nt
> selftests and validation harness.
>=20
> Patch breakdown:
> - 1/10 converts the Ceph inode flags to named bit positions and keeps the
>   file-lock error bit ready for atomic bitops.
> - 2/10 adds a bounded wait and diagnostics to wait_caps_flush().
> - 3/10 adds reset state tracking and blocks new metadata requests and loc=
k
>   acquisition while reset is in progress.
> - 4/10 adds the manual reset debugfs control surface, status reporting
>   plumbing, scheduling hooks, and tracepoints.
> - 5/10 adds the initial reconnect-based reset worker and the reconnect
>   completion tracking needed by that worker.
> - 6/10 switches reset recovery from reconnect to direct session teardown.
> - 7/10 adds the explicit reset state machine, bounded drain phase, and
>   richer status reporting.
> - 8/10 removes reconnect bookkeeping left behind by the direct-teardown
>   design.
> - 9/10 queues CEPH_SESSION_REQUEST_CLOSE before the forced teardown so
>   the MDS can release state immediately.
> - 10/10 adds the single-client stress, corner-case, and validation tests
>   used to exercise the reset flow, and passes the configured debugfs root
>   through the validation wrapper so child scripts observe the same client
>   namespace.
>=20
> Alex Markuze (10):
>   ceph: convert inode flags to named bit positions
>   ceph: add bounded timeout and diagnostics to wait_caps_flush()
>   ceph: add client reset state and request gating
>   ceph: add manual reset debugfs control and trace plumbing
>   ceph: implement reconnect-based manual reset worker
>   ceph: replace reconnect with direct session teardown in manual reset
>   ceph: add reset state machine, drain phase, and status reporting
>   ceph: drop reset reconnect bookkeeping after direct teardown switch
>   ceph: send SESSION_REQUEST_CLOSE before forced teardown in manual
>     reset
>   ceph: add single-client reset selftests and validation harness
>=20
>  fs/ceph/caps.c                                |   7 +
>  fs/ceph/debugfs.c                             | 172 ++++-
>  fs/ceph/file.c                                |   2 +-
>  fs/ceph/locks.c                               |  24 +-
>  fs/ceph/mds_client.c                          | 630 +++++++++++++++-
>  fs/ceph/mds_client.h                          |  38 +-
>  fs/ceph/super.h                               |  60 +-
>  include/trace/events/ceph.h                   |  60 ++
>  tools/testing/selftests/filesystems/Makefile  |   1 +
>  .../selftests/filesystems/ceph/HOWTO.md       | 121 +++
>  .../selftests/filesystems/ceph/Makefile       |   6 +
>  .../selftests/filesystems/ceph/README.md      |  40 +
>  .../filesystems/ceph/reset_corner_cases.sh    | 707 ++++++++++++++++++
>  .../filesystems/ceph/reset_stress.sh          | 682 +++++++++++++++++
>  .../filesystems/ceph/run_validation.sh        | 317 ++++++++
>  .../filesystems/ceph/validate_consistency.py  | 291 +++++++

I don't see any selftests as part of the patchset. Is it some mistake?

Thanks,
Slava.

>  16 files changed, 3105 insertions(+), 53 deletions(-)
>  create mode 100644 tools/testing/selftests/filesystems/ceph/HOWTO.md
>  create mode 100644 tools/testing/selftests/filesystems/ceph/Makefile
>  create mode 100644 tools/testing/selftests/filesystems/ceph/README.md
>  create mode 100755 tools/testing/selftests/filesystems/ceph/reset_corner=
_cases.sh
>  create mode 100755 tools/testing/selftests/filesystems/ceph/reset_stress=
.sh
>  create mode 100755 tools/testing/selftests/filesystems/ceph/run_validati=
on.sh
>  create mode 100755 tools/testing/selftests/filesystems/ceph/validate_con=
sistency.py

