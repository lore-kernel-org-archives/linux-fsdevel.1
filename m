Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC6B72DB797
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Feb 2026 10:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770115142; cv=none; b=nAFVitqVRy9V1Grn9JzzV6mpWNwygCjbnojl1wbLNimCM9zW6JbHjGfTTqlGKIa3sGbN+iHAKpAZ3rQcYtk8iXyvkRf0RBXL024In/gKuX9t3db9pJ32EblLwgS471oXpC1z82bAWAisc3vKHOksd/7ADP4IccJIba9GoIsyQzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770115142; c=relaxed/simple;
	bh=zCFMdpjfE+hTZAFhLEZFMEJRzLOeWmatpYc1JlHbPz0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IQpgyLhR9RXNe+8iTb8a6Vo+gVXjmg+q5WnQnFVMZ/b7Wk3fH65dw9xbIHNbJx0eIdwrjkdSL+TSHZarRbL9M96adeGrc0czuGFSCZCKZjSWxJp/tnc5h7QQnB1c4w2Qpa6PLCNoaLcTuhlIZpE4/NtQPaN2iNaVPmrXCbKx2xM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=cK56jcpw; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="cK56jcpw"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:References:In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=DX5ZAY1xzf4DYPrL9r2a5bzo4V10CiJBGW6mZ7U17zM=; b=cK56jcpwBmxyHQX2N0swn4eCSU
	LssyRmPgGLXbvOOajRYJmxrpLk5iQYobZ4EK9hfmuvr3Uj5mOuHnYj60xeAHOwDTaXJ2hL+ft69nz
	mkYq0sHuAzEk/v9y2KNFK5uBHu2l/v1d5kDAgCxaMWPteTuGx14uvbQyedcdWlBlkx9QhklVIti4t
	QC8QKtC/b/CpTDvk+lKiKiXvtiXH4RbzWD7IijA7X280QDS/vMH+H8r11m0mQRdsmdct7yNP1XlXL
	ztwlEC6Y11OcugXcVC3rYg0y6CKTSDLt10dVfiGQ1I1qVCClVLH2Z9F3rPcRfahHEwBZHSFOhlXez
	VCyAyIzg==;
Received: from bl17-145-117.dsl.telepac.pt ([188.82.145.117] helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1vnDo7-00DAmm-0E; Tue, 03 Feb 2026 11:38:55 +0100
From: Luis Henriques <luis@igalia.com>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>,  linux-fsdevel@vger.kernel.org,
  Joanne Koong <joannelkoong@gmail.com>,  "Darrick J . Wong"
 <djwong@kernel.org>,  John Groves <John@groves.net>,  Bernd Schubert
 <bernd@bsbernd.com>,  Horst Birthelmer <horst@birthelmer.de>,  lsf-pc
 <lsf-pc@lists.linux-foundation.org>
Subject: Re: [LSF/MM/BPF TOPIC] Where is fuse going? API cleanup,
 restructuring and more
In-Reply-To: <CAOQ4uxjKHptXXCJzpwU6jvGKiqTuRBOSesmpzGGUTgcJqW_gbQ@mail.gmail.com>
	(Amir Goldstein's message of "Tue, 3 Feb 2026 11:20:12 +0100")
References: <CAJfpegtzYdy3fGGO5E1MU8n+u1j8WVc2eCoOQD_1qq0UV92wRw@mail.gmail.com>
	<CAOQ4uxjEdJHjbfCFM364V=tBrEyczYvzo-b-Xo0UPOCA2cnPGQ@mail.gmail.com>
	<87cy2myvyu.fsf@wotan.olymp>
	<CAOQ4uxjKHptXXCJzpwU6jvGKiqTuRBOSesmpzGGUTgcJqW_gbQ@mail.gmail.com>
Date: Tue, 03 Feb 2026 10:38:49 +0000
Message-ID: <878qdayuva.fsf@wotan.olymp>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 03 2026, Amir Goldstein wrote:

> On Tue, Feb 3, 2026 at 11:15=E2=80=AFAM Luis Henriques <luis@igalia.com> =
wrote:
>>
>> On Mon, Feb 02 2026, Amir Goldstein wrote:
>>
>> > [Fixed lsf-pc address typo]
>> >
>> > On Mon, Feb 2, 2026 at 2:51=E2=80=AFPM Miklos Szeredi <miklos@szeredi.=
hu> wrote:
>> >>
>> >> I propose a session where various topics of interest could be
>> >> discussed including but not limited to the below list
>> >>
>> >> New features being proposed at various stages of readiness:
>> >>
>> >>  - fuse4fs: exporting the iomap interface to userspace
>> >>
>> >>  - famfs: export distributed memory
>> >>
>> >>  - zero copy for fuse-io-uring
>> >>
>> >>  - large folios
>> >>
>> >>  - file handles on the userspace API
>> >>
>> >>  - compound requests
>> >>
>> >>  - BPF scripts
>> >>
>> >> How do these fit into the existing codebase?
>> >>
>> >> Cleaner separation of layers:
>> >>
>> >>  - transport layer: /dev/fuse, io-uring, viriofs
>> >>
>> >>  - filesystem layer: local fs, distributed fs
>> >>
>> >> Introduce new version of cleaned up API?
>> >>
>> >>  - remove async INIT
>> >>
>> >>  - no fixed ROOT_ID
>> >>
>> >>  - consolidate caching rules
>> >>
>> >>  - who's responsible for updating which metadata?
>> >>
>> >>  - remove legacy and problematic flags
>> >>
>> >>  - get rid of splice on /dev/fuse for new API version?
>> >>
>> >> Unresolved issues:
>> >>
>> >>  - locked / writeback folios vs. reclaim / page migration
>> >>
>> >>  - strictlimiting vs. large folios
>> >
>> > All important topics which I am sure will be discussed on a FUSE BoF.
>>
>> I wonder if the topic I proposed separately (on restarting FUSE servers)
>> should also be merged into this list.  It's already a very comprehensive
>> list, so I'm not sure it's worth having a separate topic if most of it
>> will (likely) be touched here already.
>>
>> What do you think?
>
> We are likely going to do a FUSE BoF, likely Wed afternoon,
> so we can have an internal schedule for that.
>
> Restartability and stable FUSE handles is one of the requirements
> to replace an existing fs if that fs is NFS exportrable.

Great, thanks Amir.  So I'll just assume these topics will be pushed into
the BoF.  It looks like it will be a very interesting afternoon! ;-)

Cheers,
--=20
Lu=C3=ADs
