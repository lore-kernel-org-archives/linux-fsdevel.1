Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 229203C10AC
	for <linux-fsdevel@vger.kernel.org>; Tue, 21 Jul 2026 10:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784628750; cv=none; b=bqn0jTlzX5rdK5B7QOKUmV4U6gBk5ften4LhZKsOlg00Mx5YYOyrtzINZhTUZADXH8ElZEmdDN82XZvcL/QJpLQd3ELyHbxJghRWKrkMqWU3IvQbeWT0MLKuwxqhBTz1ZCo8wOZ/grATI5dNIBDe280MRtgBEAMYo9zVDV5cUo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784628750; c=relaxed/simple;
	bh=IGYInen6tj9/7leyVQN3CjQ+NfQdJ/cNwHn3CiDCk9A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IztgwS397IgsIoXhr/+FjY6n9kVBnjVROv6ExspNapTIIroWLNKa7rqHhTvpiih84l0pZ122BZeI/MdU1ct/gFTPmatM/yuJpTZAI30ZaRAe73awL56yZP04/tQk+6E8JH5NCol5A6QDNUDzy205C83XAwT3/I48doePjVh62zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i3gKsLuD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i3gKsLuD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C84631F000E9
	for <linux-fsdevel@vger.kernel.org>; Tue, 21 Jul 2026 10:12:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784628748;
	bh=IGYInen6tj9/7leyVQN3CjQ+NfQdJ/cNwHn3CiDCk9A=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=i3gKsLuDnAv/16DQfUG6H5gSaA69OjJ/BatgqgvnS9t9tgoWJD1HuFM2CLoCOPCk3
	 99CTk30j4Y6OFn4QHWrC2UUIFgtRr+xyRUpq5/DUFB/dzMkaWJOCKqwxfcx2iwDlo+
	 F9iK4CUMXBoFI8ZGGVCVoNqPioGSQ9Ad3AvFcORaExxjBm8Pcyt++U2xs9q0/JpTKs
	 jMZP/glPqueGAiuLSg4w84s/4dKPNuPIYHUcaO1JV7jWFn594ctAYBfrB+/RLHP+FV
	 i95eC6hc4ClKyDx0+YxyBdEEaEEa0/2aP5I2XixVm/wKeyCpE7W5ezI1SA7rqjvE5X
	 18UqlaOMkv5hA==
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-6685001353fso2832821d50.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Jul 2026 03:12:28 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RqdDXGvfXHH9osu9j18O8mN7Kt4b+oimWNG1Fs15Q6S/7GukLi7Vq9M7/kFLk2fFb/BvWRXk4zsk6tK0swd@vger.kernel.org
X-Gm-Message-State: AOJu0YwMMUWghaKbL1N+L/aTSmhqYmgg+EEY/KCqVKCOjBx0N2ez1dPv
	ugc+vrHf0+sgOVrVE4I25PAIlYuxTsjmkVGpxFMWmUUvwxRWrUaP0IGzwVVcpDUTaP/tlFInrqB
	yp/E/hjJGhIbNBY4pA+Rm3ushFMECuHQ=
X-Received: by 2002:a05:690e:1552:10b0:667:bb0f:1c26 with SMTP id
 956f58d0204a3-6683bb2f842mr4053129d50.7.1784628747287; Tue, 21 Jul 2026
 03:12:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260720210202.1163861-1-joannelkoong@gmail.com> <20260720210202.1163861-8-joannelkoong@gmail.com>
In-Reply-To: <20260720210202.1163861-8-joannelkoong@gmail.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Tue, 21 Jul 2026 19:12:12 +0900
X-Gmail-Original-Message-ID: <CAKYAXd9RMF-RXMKSfU9JGFFQxDFg-rukSczX7NEWfXCfw9ru1A@mail.gmail.com>
X-Gm-Features: AUfX_mw-cyU9F_VBYxw0bwrb7OHUZVdl_60aV8eCTvWbQbuOeoFlwIw7vxW9yaU
Message-ID: <CAKYAXd9RMF-RXMKSfU9JGFFQxDFg-rukSczX7NEWfXCfw9ru1A@mail.gmail.com>
Subject: Re: [PATCH v3 07/20] ntfs: convert iomap ops to ->iomap_next()
To: Joanne Koong <joannelkoong@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, hch@lst.de, "Darrick J . Wong" <djwong@kernel.org>, 
	linux-fsdevel@vger.kernel.org, changfengnan@bytedance.com, kbusch@kernel.org, 
	Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>, Jonathan Corbet <corbet@lwn.net>, 
	David Sterba <dsterba@suse.com>, Dan Williams <djbw@kernel.org>, Gao Xiang <xiang@kernel.org>, 
	"Theodore Ts'o" <tytso@mit.edu>, Jaegeuk Kim <jaegeuk@kernel.org>, Miklos Szeredi <miklos@szeredi.hu>, 
	Andreas Gruenbacher <agruenba@redhat.com>, Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>, 
	Hyunchul Lee <hyc.lee@gmail.com>, 
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>, Carlos Maiolino <cem@kernel.org>, 
	Damien Le Moal <dlemoal@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 21, 2026 at 6:02=E2=80=AFAM Joanne Koong <joannelkoong@gmail.co=
m> wrote:
>
> Convert ntfs iomap_ops to the new ->iomap_next() callback. Each callback =
is
> generated with the DEFINE_IOMAP_ITER_NEXT()/DEFINE_IOMAP_ITER_NEXT_END()
> macros, which wrap the iomap_iter_next() helper to finish the previous
> mapping if needed and produce the next one. No functional changes are
> intended.
>
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Thanks!
