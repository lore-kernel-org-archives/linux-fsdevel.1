Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC29D3469F4
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Apr 2026 14:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776176327; cv=pass; b=alqW+lnUKS3xTnV9s3dxT+29colDdEogVSoJhiNKP4ev62SfI2aDalO7W7Y6B7hmhwOt9VbNmQaxmCM1JOTmsJbd7PTBetBUj9ctKQyBDw44B0W/qwEjiwYvDI5H+STGXDl/5yKwMy1fmKInOnbMt8wnfrlBoGJgJobbsB4ZcC4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776176327; c=relaxed/simple;
	bh=qR1ARNJXhgZbUhvZNjjyKFCNkW5s8L/UcZxIWeoFM80=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Taqyt1cbfPIIRvooiklf3TOhgozVr2ZixlobBuveOoCebFmW4I0ioyMg34UZ7FWT4uBhQRCc58E5pKlDdRJNNaUgXBUXesf2viJKmzv5fW8VHXWxm086fuK4Q5ONzIY3fBGob56VJjUabmifnGiewD2cgJXdlU0QVodJW2FfXh0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=aLYDXS56; arc=pass smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="aLYDXS56"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-50b69bf5638so61996301cf.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Apr 2026 07:18:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776176325; cv=none;
        d=google.com; s=arc-20240605;
        b=g8IXgmllJIfjc/005AitCMOt7aqPySCbS9RvOp54br2Tzge/NCLZpENAN2BTkjrBPC
         X5CPDA3M7TiXeaW0qUdU35POoEYk2QLb9bcVtIXW585RNykKJ6JPKDghqqioi1+2Ig9i
         K/vWmQ1IwUUNI2hLkUfO3l7/GPv43eedybjjlEYd24TqxrLHe+Hk/36NORGhto99xccg
         cyGmtqu+QF9l79pNG1qQd8Xe5mq+ShaopJkJWjgWE4AgX3flJ4tyD+jyzdfGcS0AdepC
         7U77h9wt6tOjlsNbnWOowygc/HQgniI20LpR5x21uQkR7eN9KYp47neUqKGIYbmqCxNW
         fJgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=BeSg31i3cb+7JrMZOeE8E9eFnlQ6LWh5RGdI+wJ//2Q=;
        fh=hmsYW6H9/K2TFiOUaR1SMLDWoAaT2GjNHELq7i03FR0=;
        b=hKL+kbU5lGG+NUkAfhppG9r9AzbOMGWJRbQ4EkhREHOb7OIMqo8lMxjhtF+cY1/Soi
         u92xO3nI0pPeodnNdA+xv3w8+EuIcM9H7bAUSwVacfq7vcEFv9lXEABA+M7arsSUsSra
         VziPqRn3nCj4dv6zgai1fpUvBTB2ckXABMvGbTvItGJwKV/KbSyt0QWbcwRxDrL0WtWr
         8J2j1RmauYLJXNW/HXYNd/a8q8C8zeFDw86G2i3+5Y3Dk4TQAboRZGnYSP7swbSTTejV
         gVGBBPYmlbRbFEHLgu+pOZE7Kb0dcqtwZ40MF+xYFlNAZNuSELqqUuz01EYeiO6VfARA
         nTFw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1776176325; x=1776781125; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BeSg31i3cb+7JrMZOeE8E9eFnlQ6LWh5RGdI+wJ//2Q=;
        b=aLYDXS56/o8us38bnHNSLqBbnL5B3SDw60KVFLMVn/2uVKQovw9c/tHGitbk1B1TRq
         3otfycQbQbx4V1lBJhjRfPkygJLtKZp21KgnlPnDvKX4AG3hanVf0Jb2efE51AtavLQs
         3O7skEOmP7d9yay0IT50KL5zSiVztehyDeaM4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776176325; x=1776781125;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BeSg31i3cb+7JrMZOeE8E9eFnlQ6LWh5RGdI+wJ//2Q=;
        b=VWepnHcPBElU2pblheLTaVOfVjbW79uRVcv28ydJhTvxAwJQFTdirV42q61Ap/OVjb
         fYL9CMT/3NUd+sADqIBTg7SxmR3l/fBRvK7UPlehZcYKqIjHag6CDEvVlKgA/LmAlQBe
         EChCSwQR34wHGIXIK8BgGx2/T4Ylr97OVjrHTraEZviUTI2ekVawXuMPR59Dx7p2Ga8M
         3MgYnnfaZsgBubUzM47SpmNq2rnw/a0OHiJkbEj2lAkTIv1hGZrujd5maC0kdEkFVIzH
         uomeIC0+UJnGNHuuBaT2/TgqTZaR18sz047pGgzk88Bdygv1WXBWNL7etVhwMq1e5/AS
         Tf3A==
X-Forwarded-Encrypted: i=1; AFNElJ+jRDn90y727NOdDQxEijs8dxg4stcsLC6Fg5tTc0UpyvcIOFa261p8cAeR/o4+bRHezMJPRCI70lw/wCQ/@vger.kernel.org
X-Gm-Message-State: AOJu0YyUxTrwMRJNynO8AVMkDSRnwfxhjfblK575clqvUw58rKvWZnrG
	pRJw8Lea/dX3NJYCXwoIplwlDHVL5ea13YHCCawNlk0+njB5e0YtJGPQoVzmvfBLHjRkJobT3gX
	KxTEHfAGKGtXtVUQ2+culIkZ3fI+6wHR1LK6MfEoTbA==
X-Gm-Gg: AeBDietMh8nXq7QGuayAsXtXW4MSsX+uF6vAPIekwsniqO6CHzI0JV3IrFSe8kmEt8v
	KvAx5u6cfxbz+2jGV5G0pUJOkhXo7Q6xA0ByNclGASnwYESDm+Wu1zU0VEUO5OyyMAL60bkdRBR
	w6MieiU+moIhxvnhlWGg3ZWPkLU/LFTPH2XEH8t+rPVsPaswzoukmUUYa3uaLjcgAmTckGJf6B+
	XXedkcAkb2WjQa6jVtQfsCk6R2qwLfKr6vxQrejbfUx848V+N+R6pg0rKz7t7kZOqshtC4YaT30
	rJUiPnH6EOMCzueTUwqv4KP7NmO8Gqy1SI9YjXLwRKQhWZI=
X-Received: by 2002:ac8:5d89:0:b0:50d:7135:5631 with SMTP id
 d75a77b69052e-50dd5b959fcmr266547411cf.6.1776176324547; Tue, 14 Apr 2026
 07:18:44 -0700 (PDT)
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
 <CAJfpegvVTcV89=q3L326aGQjhduBcv7PVg5QKftGLjNZmCLmaw@mail.gmail.com> <ad4_jFsR951c2Mtn@groves.net>
In-Reply-To: <ad4_jFsR951c2Mtn@groves.net>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 14 Apr 2026 16:18:33 +0200
X-Gm-Features: AQROBzCjv32eXkH-VR3uBgnPuhuKjz5ZLSL9EY66Hi1IQzByLu6JpgnFl7pVZ3s
Message-ID: <CAJfpegsCoMMg-Ux3CbBh0d1uqDNg3Fu_8YE-LubwrQ6A-2Cggw@mail.gmail.com>
Subject: Re: [PATCH V10 00/10] famfs: port into fuse
To: John Groves <John@groves.net>
Cc: Joanne Koong <joannelkoong@gmail.com>, Bernd Schubert <bernd@bsbernd.com>, 
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

On Tue, 14 Apr 2026 at 15:41, John Groves <John@groves.net> wrote:

> My short response: Noooooooooo!!!!!!

:) Seems like this is a highly emotional topic...  I suggest that we
go ahead with bpf experiments, then discuss results and path forward
at LSM.

Thanks,
Miklos
