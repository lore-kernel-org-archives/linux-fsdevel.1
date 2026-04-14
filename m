Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1033634EF08
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Apr 2026 13:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776172792; cv=pass; b=eBIW+Hz5RATnCaTlA4NbIVp5lLZDiYok0NlJ9AvK3TCmVtYFFRh998NegPjUD7dr+HctSswbfR2QyP/bR0pajIYr7WKgtZJkzte3UGHAe/3HFe/RXOtvW1FabVrbYDPaQvZLIEog04E0er3vAiRXiT9CarW1wobDeoqla4oioVs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776172792; c=relaxed/simple;
	bh=ryFgEXHGkmMuSpJJwpuJTVtwXQi8vggb0ychK1MApVo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y1GtLijgpkFojgneuxou/AWYlkF/Kgtu5sdMUHRgQY0yjglvhFSUjuLjF3W6CKpTHD1DG0o4SIMAwk5PgIlD8tACvaeAW7VW0vGpLcnpALPDctN1X8ki7Twlmerb+OUzMkruZoH275wuKCnNTbd7GiyBwX5CVWCv4NxLGLlFcYY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=EdesvKDz; arc=pass smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="EdesvKDz"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-506bcb23a78so40463051cf.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Apr 2026 06:19:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776172790; cv=none;
        d=google.com; s=arc-20240605;
        b=MZk7IpqI/G7iHxL2mjidicys7vD+HWqNVpAnXLanHgAdjyenWDkTv4kHtavvH9lInF
         VY4kixax17j/rMkxdFHDch2EZhTAyGYHANOVffmru9HbtH99jyCAPxRMrAHjvdfAcNIM
         v4ePbAqqx1dvS+yHjnUYdr/kEjKQMrOiyJMiSRIyFvQj2pHqrri3ydOymg+RXyMPvqVH
         ziEBwkHJpi/CDMod7Sbg105OMfCaolxsBZTbjwDmVjQqUHWSC/mwpO7bcxD12tHrzQ/3
         5VAeYo782g8DGv19PLNxDebrR7eAs9ToioLNEjEcwYcf7LX7BRQsvOB+Qq6pWjgb+MaF
         n66A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=+CXxVRVcoz/2rqD2Y6nyYCqWM6bYEnwjERb2zuGyero=;
        fh=VYockJyZgYVFl1w3Zy4kL1i6mAEDl0IPPCIS6VYAJEM=;
        b=CoZ16ZQBnjIgnQeqyzvoCU+iLErAKbN17Mrqty/nVUoZ7Z00oZGfgLe0pq0W0qoCR9
         dY0H1m4gJnFoDKqz/QFloeL7uKcxqCcDufXFpH0f+/KRz5n4iB1EmAs1S1exjYhbuG4U
         0kYIzaQmPzqKuLtmFCwb5A7aMNhBz6Jdi+HA0VFKxAbF1uWMSx4uVityHyKYtUjaXZ1H
         c3UpuTL2q/3hC3umLLUrZ+j80Mkx0Ft8wOjt+ndIbJ46oBRp7tMQ/Hy4sgGoikSInxY/
         wlEjTai6m2Z3y0mfZ0VUAsXuAEd7hq3PeZWbtvA3cRI7EHudFjjnGSt+q0PV1W345iES
         cDKg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1776172790; x=1776777590; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+CXxVRVcoz/2rqD2Y6nyYCqWM6bYEnwjERb2zuGyero=;
        b=EdesvKDzFMu6T/NN5owN0NDzG9s+SXgDPUsDbVYCn9yKIf8kwdQE2lTuYVmGiAxzE9
         0DHMCrmYz6U1MzaS5L9krJ64waA1cSWpenp3CcdBgFkMfiSvvJgMJCraKAc1dSuOHo18
         bUw+BOsn4AQvTlcbhfLZdWy6XiGKSVD/tAHlM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776172790; x=1776777590;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+CXxVRVcoz/2rqD2Y6nyYCqWM6bYEnwjERb2zuGyero=;
        b=qfqvwnC9goZraGEz+vJjptL1cZLKECyggxiNXzwrCbi29FS/PisChzn+/nu3zydbH3
         vbVKQvlnd1GtaV8AslB9d7bfp1TMuD/n6PoNJo/BPUBFzV1j3L858CY44i5vrQT9iiQD
         p3jmMgDThAZxnGbq70vg0+Ei/Y8bTXvlxsd9N7bMyCvXsHqGMdBrpUkzw8k0ZcaFrTbW
         bR57lRGHzAnfFNZ+EqzDH5VBH+OZAksj64f81cCcogxTf7OD//DxIN0oi/eb5GVbp0oq
         5P2Pw8mMoAxzpZu6PKzSdDcBU4CWqm2mMsWETd5lKgu6sWmWWriobc9FRxyOx1r80tU2
         AWDg==
X-Forwarded-Encrypted: i=1; AFNElJ+QDyyNWFv2wc75KaJsJllQc7Re97h/I4yuD0/1AelLeLeCtVOJLjQ2V0pNIsso4gK8oSHccbfm2nwNfaK8@vger.kernel.org
X-Gm-Message-State: AOJu0YyzxB2Bj4xe0GPgGMGeqcArg4L4irFek2lxn+vqvv+QLaHS/8iV
	TFd7SmJxMCKBAP4D5WrysJ21hygxX84rn1HgSZHy+wxhnENyNr0bOLp1259JDXTH8uwkbCVniN3
	DwtdmflWEyImG6QnZgEOAUeergRmr835BRyDFrKcPdw==
X-Gm-Gg: AeBDieuXNj7ohp44Tnu6r5r3RmRnQHn6p8zxE7KQFlqs0lwRYhVj7olVt0LWnn4rf1h
	4f0MPlfVlhhNiubMZOw1u7e1e3i6f6AMLhMBhOaeAK7AT/30DBKVLkmL6xteMCz3e3XfED8ZzBU
	lv1Z33g04TkEDLI3c1lWP/Mgxfark5dXxiMR6lyT2FOVwCUKqA57ffOjR8eXRjrC2g5+jdM0MFz
	2OfBtpC2OzIpjrJhiy+vmaoVqLlyVSK4pv/MM7FDbANn+7pA0RYvz2zm54RejtUk7ihmQUA67dl
	HZ8xhBzP/ep6gEmYjaWOB0mvQxy45BoRU9WP
X-Received: by 2002:a05:622a:1114:b0:50d:e471:2d1e with SMTP id
 d75a77b69052e-50de471307cmr196909641cf.35.1776172788501; Tue, 14 Apr 2026
 06:19:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260331123702.35052-1-john@jagalactic.com> <0100019d43e5f632-f5862a3e-361c-4b54-a9a6-96c242a8f17a-000000@email.amazonses.com>
 <CAJnrk1ZRTGWjNzkMxS3UkeZMmrpadJDtWKontMx2=d-smXYq=w@mail.gmail.com>
 <adkDq0m5Wt9YhJ8A@groves.net> <38744253-efa3-41c5-a491-b177a4a4c835@bsbernd.com>
 <adlBcwJjLOQDAR65@groves.net> <CAJnrk1a06zkUmXW5EFiUmgAoFauwtzsYvnotaPH0ifVtyh7iDQ@mail.gmail.com>
In-Reply-To: <CAJnrk1a06zkUmXW5EFiUmgAoFauwtzsYvnotaPH0ifVtyh7iDQ@mail.gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 14 Apr 2026 15:19:36 +0200
X-Gm-Features: AQROBzAjmnDDuarHcsoLUx4J604uFTw3mmrQVyJlb1VBhLQLJU1-3tqIq-XH-a0
Message-ID: <CAJfpegvVTcV89=q3L326aGQjhduBcv7PVg5QKftGLjNZmCLmaw@mail.gmail.com>
Subject: Re: [PATCH V10 00/10] famfs: port into fuse
To: Joanne Koong <joannelkoong@gmail.com>
Cc: John Groves <John@groves.net>, Bernd Schubert <bernd@bsbernd.com>, 
	John Groves <john@jagalactic.com>, Dan Williams <dan.j.williams@intel.com>, 
	Bernd Schubert <bschubert@ddn.com>, Alison Schofield <alison.schofield@intel.com>, 
	John Groves <jgroves@micron.com>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Vishal Verma <vishal.l.verma@intel.com>, 
	Dave Jiang <dave.jiang@intel.com>, Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, David Hildenbrand <david@kernel.org>, 
	Christian Brauner <brauner@kernel.org>, "Darrick J . Wong" <djwong@kernel.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Jeff Layton <jlayton@kernel.org>, 
	Amir Goldstein <amir73il@gmail.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	Stefan Hajnoczi <shajnocz@redhat.com>, Josef Bacik <josef@toxicpanda.com>, 
	Bagas Sanjaya <bagasdotme@gmail.com>, Chen Linxuan <chenlinxuan@uniontech.com>, 
	James Morse <james.morse@arm.com>, Fuad Tabba <tabba@google.com>, 
	Sean Christopherson <seanjc@google.com>, Shivank Garg <shivankg@amd.com>, 
	Ackerley Tng <ackerleytng@google.com>, Gregory Price <gourry@gourry.net>, 
	Aravind Ramesh <arramesh@micron.com>, Ajay Joshi <ajayjoshi@micron.com>, 
	"venkataravis@micron.com" <venkataravis@micron.com>, 
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>, 
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, djbw@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 10 Apr 2026 at 21:44, Joanne Koong <joannelkoong@gmail.com> wrote:

> Overall, my intention with bringing this up is just to make sure we're
> at least aware of this alternative before anything is merged and
> permanent. If Miklos and you think we should land this series, then
> I'm on board with that.

TBH, I'd prefer not to add the famfs specific mapping interface if not
absolutely necessary.  This was the main sticking point originally,
but there seemed to be no better alternative.

However with the bpf approach this would be gone, which is great.

So let us please at least have a try at this. I'm not into bpf yet,
but willing to learn.

Thanks,
Miklos
