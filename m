Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F2C54CDDEF;
	Tue, 29 Sep 2026 14:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790693654; cv=none; b=PRF+8Sx+JAy4f6LmsVD20MgGwwyi70jZeFJV5CBqmyDN/XZXzKsp3xMP20ZVtxL30EujaLQ3fk08u51BykMiOYagr5/3m2/Fy2wMGGM9ajX13QPrzaRG6SYjKzd9OLFjZPCjnEPIWjXpj9TYuIoczRF1DYUlPOZKMFXWLbqVbiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790693654; c=relaxed/simple;
	bh=YjJznT4b0xAdGZ2PiRCaweISyYHg5n6lSKL0jyLHXAE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rGxO9AHjd4p4TqT8paBBqn3MaLxAKsUfAD09UY9j6aM69EcPJbyLnnO3E14uDYl0U0yppOLb/Ttxy+Pf8J+z0AzEe9HLhsXRdLitn9JMvpKfVX5OrrdgNhrHoxlUIv995q9vAXC4o33G/3m/y8xmjUME+37k7738zgafj8XO+wM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=W4NvXe3S; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="W4NvXe3S"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=cSs4Fxg3+Gv+8PrdKz5gHVkl12+opkOvD2Y/1wSCg1U=; b=W4NvXe3SsF07/exlGJuu7PFGcr
	oqJNY4ii6Pa+mC1AsWqbfSQb1SkF+u8EyvwtRxE/mrN7nTHS9Az3CRxSfukMnzPQm1Y7qkMuBMEFO
	HTd8ZV7WYtilYUrqoUQaHMTiQxYs8c5jQBZgVn8JtHIhrjnN1AhT49SknvhGLuLhba/XnOGN7M3XQ
	TFTrFl6IrOEH1jA+33xeoUtX+U3f0wUa0QdUJO2DHpXn54Mft0Tbn3lZdMjdOWgx3nIjRDihdOdsD
	+5Au6QmfFGbZkFkviLoDr8Z3+YjtjLDq93Wcout5uxJKzL4GxRF7h5dE/yPBWZXKRUo2BmvYBMWbd
	I8aN0YxA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xBZDS-0000000D1nR-1pym;
	Tue, 29 Sep 2026 14:53:59 +0000
Date: Tue, 29 Sep 2026 15:53:58 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Georgios Androutsopoulos <georgeandrout13@gmail.com>,
	Miguel Ojeda <ojeda@kernel.org>, Jan Kara <jack@suse.cz>,
	Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Tamir Duberstein <tamird@kernel.org>,
	Alexandre Courbot <acourbot@nvidia.com>,
	Onur =?iso-8859-1?Q?=D6zkan?= <work@onurozkan.dev>,
	linux-fsdevel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] rust: file: handle fd table teardown in file
 descriptor APIs
Message-ID: <20260929145358.GC989762@ZenIV>
References: <20260923022339.3340694-1-georgeandrout13@gmail.com>
 <arThye_219ruNbM2@google.com>
 <20260925-stellen-brummen-festrede-266af0305ac7@brauner>
 <20260929044843.GA3909609@ZenIV>
 <art7swUNAa3AyUrL@google.com>
 <20260929132839.GA989762@ZenIV>
 <CAH5fLgis-9ibYAEK-shQtwg_08Le-JDYChS77LugEhgZ=T+z8Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAH5fLgis-9ibYAEK-shQtwg_08Le-JDYChS77LugEhgZ=T+z8Q@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Tue, Sep 29, 2026 at 03:35:13PM +0200, Alice Ryhl wrote:

> Sorry I mixed it up ... the code called file_close_fd() and then
> filp_close() with current->files. The important call here is the
> file_close_fd() one, not the filp_close() one.

Er...  But that would *not* see NULL ->files in case of workqueue -
you'd get init_files instead.  vhost_task_create() is the only
thing that creates threads with NULL ->files; it might or might
not make sense to have the same for workqueue worker threads,
but that wouldn't change anything in that bug anyway.

When you want to change the state of a thread component, be it
descriptor table, cwd, umask, etc., you'd better do that in
a thread that *does* share that component with the thread you
want to have affected.

It's not a matter of race with exiting thread - closing a descriptor
via schedule_work() is _always_ wrong.

I really don't get it...
