Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C2F5313E21
	for <linux-fsdevel@vger.kernel.org>; Thu, 27 Aug 2026 07:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787814937; cv=none; b=oXgavr6qqu7jMNKOIYJ+KRYcXzjLCGtY3vdb7f/F/UYfmVWE3PSl1jlHhwuAs8XTQWIw93631SN/GzxoVcj//CpfOsM0+ojVMpC6heVUw25VDDEMPsjVsK//u1yxOi+YtaXqVV+NR51unsB9PImbvrrEeFMfcvIJFPnQa2rB8rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787814937; c=relaxed/simple;
	bh=eEbvmBA+VqV7d+OycmMNi2e9upqto8mUTrACjRl71h0=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=tlT6FgtcWmxnG6CfYGCCW8aN6tcQ4kMTRC8NJ/mM0/2NGVz0wzLqGTw+EbkWSvW/BZiQPDdToba+jnIyRo3DhhRr8FrrjlBHrj6W7uIqxO3YcewzNBmm9pEdUXRuMezK9n87495HaJRRC+0rMzK6RS7yH1HN1yK5ofVxqARq/VE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca; spf=pass smtp.mailfrom=dilger.ca; dkim=pass (2048-bit key) header.d=dilger-ca.20251104.gappssmtp.com header.i=@dilger-ca.20251104.gappssmtp.com header.b=KypGqpUq; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dilger.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dilger-ca.20251104.gappssmtp.com header.i=@dilger-ca.20251104.gappssmtp.com header.b="KypGqpUq"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2d71d1cc8b2so9492895ad.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Aug 2026 00:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20251104.gappssmtp.com; s=20251104; t=1787814931; x=1788419731; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=1zCh3657l86P60/ccD6dgvUaOyv0ZIzzK7+ahPLSOkY=;
        b=KypGqpUq2WGZEEAr+wiCzMbr2qQjppa5uXB52tbvpBhOeasDYEKKhSzOWsI+kSP9Bw
         652g42hUVP6Rb0DRIRS8uNlQ7izeiQC9eis6jQiTacSsNEQM5j0Ns1ZQ+TCCn1MVWoUp
         77A5+T+xD9Ymkc4hycOYRO4JLgOoXNRJYNYP+bb0eqD6ug1m6uwaTADTp+aQhWznmOyt
         M9QsyDsCdLcuyjkcI/ouIg6Gbr5fdF+1A8Yc1ZIeas1fdC0Agde2Ddj3RZMbLzZd+hby
         mYyN3OZLJpNCzyCk/86lVQUQqWeZfWLkA3g2Oqs9VCgZmgipLoUw1fHRJ84tt6ofCfQp
         Fk6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787814931; x=1788419731;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1zCh3657l86P60/ccD6dgvUaOyv0ZIzzK7+ahPLSOkY=;
        b=qgCRFPiL4m3WD8Oszpt9fbz+4UIEpjh8MnOsBAVUOcEFRpkajJfLiivfOOoYWi7o9h
         5YuFSPJoMIDZk951UrZR/s3Gn7yyUgoyjR9H99OtW6+s6CBlVVzmjF9RswD5jeqR865v
         KhU/Xs2I5ynqywXalSLO+q59oFN5H36V+jWjaQ5jMESTJHgMjlzEkxmy+4IL3pxs9aF1
         +p9kogu0C9MjsW24MZ9BI9BYRsObbnE/Kvx6OYAE49gdWaGcGdtaC9vwbKDpUlg/mZ5k
         u9by/Kixz5v237kXX7L4m35Eh3ktUfTHw7f2qOfA6a522k3POp73haFJig8iPHMF/p29
         uQXg==
X-Gm-Message-State: AFuF++l3XsuzL0qeSHhIoBzAaf8R9lyhIBw9g2dBs29BMZKkrfpqmf50
	0dhLcuInf2wQ9HF3fEEwGzyKXxNLBOerWGWhWOdwbLn5bsgeNT6saNG6ZkEpuwDT8ek=
X-Gm-Gg: AR+sD13VwQw4eWV5GZ2wJikO1ZRlGt6BV5SqNUVNXUV5+tYnppxWXRM5EmiHfSz8RqN
	RShIPblVEFnqAeeS84XOmLHIxSFth7ej9sO7qTUYFpinis5k6OzHDFerSuDGaIoEYdiptzXiVBC
	SCP8a7Rncav902RrnxEsPRg6yh0braXwTbYyqF0o2YgXbEndmNWRcqi5dKrEAVN+r5J+fMZKei7
	Qy5wwIpKW751/qyK9ibUmSpCqwSs+ImeJJiAjUfma5mPj4NL2Skr9cGbED31oOlvJzJfbsdlNfF
	fJZVIZ4I2/Qkr2SGz7vNpXEjCsVBTpgewB9QbpLw3yZjBss7Zz4XR5dRt2GnHtKBgGMoRn2qk+m
	SDCUQBSxo+lETi7+XWCreVXJv7xO1SRVCOe6j6TKiSU3OYjVMHAsFZH04s47I3/8rzh9YagG7h8
	BVJngmr39cjdICHIhasYyvL/cp2Tt/Qe6NkvYaZkcojQhg7a4Rj3urnDgOBhneMbOxJZuCPYBLb
	LYswkwyGveOdAuzEQ8=
X-Received: by 2002:a17:90a:fc47:b0:38e:9045:bac0 with SMTP id 98e67ed59e1d1-3966d1b1f18mr27681280a91.5.1787814931510;
        Thu, 27 Aug 2026 00:15:31 -0700 (PDT)
Received: from smtpclient.apple ([2604:3d09:3a84:1700:519f:762d:ed84:5e92])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-396b1992e05sm1553252a91.15.2026.08.27.00.15.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Aug 2026 00:15:30 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.100.1.1.5\))
Subject: Re: [RFC] statx: Define a generic OFFLINE file attribute
From: Andreas Dilger <adilger@dilger.ca>
In-Reply-To: <e06bdbf8-3727-425c-9a82-150848613a6b@mail.infomaniak.com>
Date: Thu, 27 Aug 2026 01:15:19 -0600
Cc: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <3F6C9003-B8DE-4CE4-A158-702D29E6CB37@dilger.ca>
References: <e06bdbf8-3727-425c-9a82-150848613a6b@mail.infomaniak.com>
To: Lukas Mathis <lukas.mathis@ikmail.com>
X-Mailer: Apple Mail (2.3864.100.1.1.5)

On Aug 26, 2026, at 14:23, Lukas Mathis <lukas.mathis@ikmail.com> wrote:
>=20
> Background:
> During the 2024 discussion on additional statx() attributes, the =
introduction of a generic STATX_ATTR_OFFLINE attribute was proposed and =
discussed as a potentially useful cross-filesystem property. The =
discussion highlighted use cases in HSM systems, network filesystems, =
and userspace tools that need to distinguish fully available files from =
files whose content is not immediately accessible.

FYI, there is already `FIEMAP_EXTENT_UNKNOWN` which indicates the same =
information,
namely that the file data is inaccessible and cannot be mapped to =
blocks.

Having a statx() flag pass on the same information seems useful, since =
it should be
much lighter weight than calling fiemap to get a single bit of =
information.  However,
it makes sense that if `STATX_ATTR_OFFLINE` is returned for a file then =
fiemap
should also consistently return `FIEMAP_EXTENT_UNKNOWN` for that file.

Cheers, Andreas

> Since then, Linux has gained support for pre-content access =
notifications through FAN_PRE_ACCESS, which provides a mechanism for =
userspace to supply file data before read access proceeds. This =
addresses a significant part of the data access path for content that is =
not immediately available locally.
>=20
> However, userspace still lacks a standardized way to determine whether =
a file's contents are currently available without triggering access.
>=20
> This RFC revisits the earlier discussion and proposes a minimal and =
filesystem-agnostic solution.
>=20
> Problem Statement:
> Today, userspace applications can determine many file properties =
through statx(), but there is no generic mechanism to discover whether =
file content is immediately available.
>=20
> As a result:
> General-purpose tools cannot distinguish between available and =
unavailable file content.
> Filesystems may implement similar semantics differently.
> Userspace software lacks a common API for querying content =
availability.
> The recently introduced pre-content access infrastructure can hydrate =
content when accessed, but applications cannot discover the state =
beforehand.
> Proposal
>=20
> Introduce a new statx() attribute:
> STATX_ATTR_OFFLINE
>=20
> Semantic definition
> A file marked with STATX_ATTR_OFFLINE satisfies the following =
condition:
>=20
> The file's metadata is available, but the file's content is not =
currently guaranteed to be immediately accessible without additional =
retrieval, restoration, hydration, or staging work.
>=20
> This definition intentionally avoids any assumptions regarding:
> - storage technology
> - retrieval mechanism
> - userspace implementation
> - caching policy
> - filesystem type
>=20
> The attribute describes the current availability of file content and =
nothing more.
>=20
> Intended Usage:
> Examples of applications that may benefit from a standardized OFFLINE =
attribute include:
>=20
> - search tools
> - backup software
> - indexing services
> - archiving software
> - HSM implementations
> - filesystem management utilities
>=20
> Example:
> statx file.dat
>=20
> could return:
> Attributes OFFLINE
>=20
> allowing userspace applications to make informed decisions before =
opening the file.
>=20
> Non-Goals:
> This proposal does not attempt to standardize:
> - synchronization status
> - upload status
> - conflict states
> - caching policies
> - retention policies
> - provider-specific metadata
> - graphical user interface behavior
>=20
> In particular, this RFC intentionally does not propose attributes such =
as:
> - PINNED
> - SYNC_PENDING
> - ERROR
>=20
> as these describe userspace policy decisions rather than generic =
filesystem content availability.
>=20
> The proposed attribute only answers one question:
>=20
> Is the file content currently offline?
>=20
> Filesystem Support
>=20
> Filesystems may expose STATX_ATTR_OFFLINE if they can reliably =
determine that file data is not immediately available.
>=20
> Implementation details remain filesystem specific.
>=20
> A filesystem may map the attribute to:
>=20
> - persistent inode flags
> - internal metadata
> - remote state information
> - HSM state information
>=20
> The RFC intentionally does not mandate how the state is stored.
>=20
> Relationship to Existing Work
>=20
> This proposal is intended as a direct continuation of the 2024 =
STATX_ATTR_OFFLINE discussion and follows the same general direction =
suggested there. The goal is not to introduce a new subsystem but to =
define a common userspace-visible semantic that can be implemented =
across filesystems and consumed by generic tools.
>=20
> The proposal is complementary to the recently introduced pre-content =
access infrastructure (FAN_PRE_ACCESS). While FAN_PRE_ACCESS addresses =
content retrieval before access, STATX_ATTR_OFFLINE provides a mechanism =
for userspace to determine content availability before attempting =
access.
>=20
> Request for Feedback
>=20
> Is the proposed semantic definition sufficiently generic?
>=20
> This RFC intentionally focuses on a single, narrowly scoped semantic =
property in order to maximize reuse across filesystems and userspace =
tools while minimizing policy decisions in the kernel.
>=20


Cheers, Andreas





